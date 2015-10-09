var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');

const PRODUCTION_URL = 'https://api.mastercard.com/moneysend/v2/mapping/card?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/moneysend/v2/mapping/card?Format=XML';

function CardMappingService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getCreateMapping = function(request){
        var body = request;
        var url = this.getUrl();
        return this._connector.doRequest(url,'POST',body);
    };

    this.getInquireMapping = function(request){
        var body = request;
        var url = this.getUrl();
        return this._connector.doRequest(url,'PUT',body);
    };

    this.getUpdateMapping = function(request, options){
        var body = request;
        var url = this.getMappingIdUrl(options);
        return this._connector.doRequest(url,'PUT',body);
    };

    this.getDeleteMapping = function(options){
        var url = this.getMappingIdUrl(options);
        return this._connector.doRequest(url,'DELETE');
    };

    this.getUrl = function(){
        var url = "";
        if (this._environment == environmentClass.production){
            url = PRODUCTION_URL;
        } else {
            url = SANDBOX_URL;
        }
        return url;
    };

    this.getMappingIdUrl = function(options){
        var url = "";
        if (this._environment == environmentClass.production){
            url = 'https://api.mastercard.com/moneysend/v2/mapping/card' + options.MappingId + '?Format=XML';
        } else {
            url = 'https://sandbox.api.mastercard.com/moneysend/v2/mapping/card/' + options.MappingId + '?Format=XML';
        }
        console.log(url);
        return url;
    };

}

module.exports.CardMappingService = CardMappingService;

