var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');
var urlUtil = require('../../common/URLUtil');

const PRODUCTION_URL = 'https://api.mastercard.com/restaurants/v1/countrysubdivision?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/restaurants/v1/countrysubdivision?Format=XML';

function CountrySubdivisionsLocalFavoritesService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getCountrySubdivisions = function(options){
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
        url = urlUtil.addQueryParameter(url, "Country", options.Country);
        return url;
    };
}

module.exports.CountrySubdivisionsLocalFavoritesService = CountrySubdivisionsLocalFavoritesService;

