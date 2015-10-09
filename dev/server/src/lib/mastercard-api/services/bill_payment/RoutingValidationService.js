var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');

const PRODUCTION_URL = 'https://api.mastercard.com/billpayAPI/v1/isRoutingValid?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/billpayAPI/v1/isRoutingValid?Format=XML';

function RoutingValidationService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getBillPayAccountValidation = function(request){
        var body = request;
        var url = this.getUrl();
        return this._connector.doRequest(url,'POST',body);
    };

    this.getUrl = function(){
        if (this._environment == environmentClass.production){
            return PRODUCTION_URL;
        } else {
            return SANDBOX_URL;
        }
    };

}

module.exports.RoutingValidationService = RoutingValidationService;

