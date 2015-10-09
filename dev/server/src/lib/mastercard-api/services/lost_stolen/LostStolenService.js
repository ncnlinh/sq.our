var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');

const PRODUCTION_URL = 'https://api.mastercard.com/fraud/loststolen/v1/account-inquiry?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/fraud/loststolen/v1/account-inquiry?Format=XML';

function LostStolenService(consumerKey, privateKey, environment, callback){

  this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
  this._environment = environment;

  this.setCallback = function(callback){
    this._connector.setCallback(callback);
  };

  this.getAccount = function(accountNumber){
    var body =
    {
      AccountInquiry: {
        AccountNumber: accountNumber
      }
    };
    var url = this.getUrl();
    this._connector.doRequest(url,'PUT',body);
  };

  this.getUrl = function(){
    if (this._environment == environmentClass.production){
      return PRODUCTION_URL;
    } else {
      return SANDBOX_URL;
    }
  };

}

module.exports.LostStolenService = LostStolenService;