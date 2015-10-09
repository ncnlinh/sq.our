var connectorClass = require('../../../common/Connector');
var environmentClass = require('../../../common/Environment');
var urlUtil = require('../../../common/URLUtil');

const PRODUCTION_URL = 'https://api.mastercard.com/atms/v1/atm?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/atms/v1/atm?Format=XML';

function AtmLocationService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getAtms = function(options){
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
        url = urlUtil.addQueryParameter(url, "SupportEMV", options.SupportEMV);
        url = urlUtil.addQueryParameter(url, "InternationalMaestroAccepted", options.InternationalMaestroAccepted);
        return url;
    };

}

module.exports.AtmLocationService = AtmLocationService;

