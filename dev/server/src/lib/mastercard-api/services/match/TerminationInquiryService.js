var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');
var urlUtil = require('../../common/URLUtil');

const PRODUCTION_URL = 'https://api.mastercard.com/fraud/merchant/v1/termination-inquiry?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/fraud/merchant/v1/termination-inquiry?Format=XML';

function TerminationInquiryService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getTerminationInquiry = function(request, options){
        var body = request;
        var url = this.getUrl(options);
        return this._connector.doRequest(url,'POST',body);
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
        return url;
    };

}

module.exports.TerminationInquiryService = TerminationInquiryService;

