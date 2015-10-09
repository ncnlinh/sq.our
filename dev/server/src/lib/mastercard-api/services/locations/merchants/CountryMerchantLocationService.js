var connectorClass = require('../../../common/Connector');
var environmentClass = require('../../../common/Environment');
var urlUtil = require('../../../common/URLUtil');

const PRODUCTION_URL = 'https://api.mastercard.com/merchants/v1/country?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/merchants/v1/country?Format=XML';

function CountryMerchantLocationService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getCountries = function(options){
        var url = this.getUrl(options);
        return this._connector.doRequest(url,'GET');
    };

    this.getUrl = function(options){
        var url = "";
        if (this._environment == environmentClass.production){
            url = PRODUCTION_URL;
        } else {
            url = SANDBOX_URL;
        }
        url = urlUtil.addQueryParameter(url, "Details", options.Details);
        return url;
    };

}

module.exports.CountryMerchantLocationService = CountryMerchantLocationService;

