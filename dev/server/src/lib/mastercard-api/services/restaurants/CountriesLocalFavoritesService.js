var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');

const PRODUCTION_URL = 'https://api.mastercard.com/restaurants/v1/country?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/restaurants/v1/country?Format=XML';

function CountriesLocalFavoritesService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getCountries = function(){
        var url = this.getUrl();
        return this._connector.doRequest(url,'GET');
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
}

module.exports.CountriesLocalFavoritesService = CountriesLocalFavoritesService;

