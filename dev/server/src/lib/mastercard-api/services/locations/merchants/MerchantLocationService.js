var connectorClass = require('../../../common/Connector');
var environmentClass = require('../../../common/Environment');
var urlUtil = require('../../../common/URLUtil');

const PRODUCTION_URL = 'https://api.mastercard.com/merchants/v1/merchant?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/merchants/v1/merchant?Format=XML';

function MerchantLocationService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getMerchants = function(options){
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
        console.log(options);
        url = urlUtil.addQueryParameter(url, "Details", options.Details);
        url = urlUtil.addQueryParameter(url, "PageOffset", options.PageOffset);
        url = urlUtil.addQueryParameter(url, "PageLength", options.PageLength);
        url = urlUtil.addQueryParameter(url, "Category", options.Category);
        url = urlUtil.addQueryParameter(url, "AddressLine1", options.AddressLine1);
        url = urlUtil.addQueryParameter(url, "AddressLine2", options.AddressLine2);
        url = urlUtil.addQueryParameter(url, "City", options.City);
        url = urlUtil.addQueryParameter(url, "CountrySubdivision", options.CountrySubdivision);
        url = urlUtil.addQueryParameter(url, "PostalCode", options.PostalCode);
        url = urlUtil.addQueryParameter(url, "Country", options.Country);
        url = urlUtil.addQueryParameter(url, "Latitude", options.Latitude);
        url = urlUtil.addQueryParameter(url, "Longitude", options.Longitude);
        url = urlUtil.addQueryParameter(url, "DistanceUnit", options.DistanceUnit);
        url = urlUtil.addQueryParameter(url, "Radius", options.Radius);
        url = urlUtil.addQueryParameter(url, "OfferMerchantId", options.OfferMerchantId);
        console.log(url);
        return url;
    };

}

module.exports.MerchantLocationService = MerchantLocationService;

