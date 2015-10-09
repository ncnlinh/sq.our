var connectorClass = require('../../common/Connector');
var environmentClass = require('../../common/Environment');
var urlUtil = require('../../common/URLUtil');

const PRODUCTION_URL = 'https://api.mastercard.com/fraud/merchant/v1/termination-inquiry/id?Format=XML';
const SANDBOX_URL = 'https://sandbox.api.mastercard.com/fraud/merchant/v1/termination-inquiry/id?Format=XML';

function TerminationInquiryHistoryService(consumerKey, privateKey, environment, callback){

    this._connector = new connectorClass.Connector(consumerKey, privateKey, callback);
    this._environment = environment;

    this.setCallback = function(callback){
        this._connector.setCallback(callback);
    };

    this.getTerminationInquiryHistory = function(options){
        var url = this.getUrl(options);
        return this._connector.doRequest(url,'GET');
    };

    this.getUrl = function(options){
        var url = "";
        if (this._environment == environmentClass.production){
            url = "https://api.mastercard.com/fraud/merchant/v1/termination-inquiry/" + options.InquiryReferenceNumber + "?Format=XML";
        } else {
            url = "https://sandbox.api.mastercard.com/fraud/merchant/v1/termination-inquiry/" + options.InquiryReferenceNumber + "?Format=XML";
        }
        url = urlUtil.addQueryParameter(url, "PageOffset", options.PageOffset);
        url = urlUtil.addQueryParameter(url, "PageLength", options.PageLength);
        url = urlUtil.addQueryParameter(url, "AcquirerId", options.AcquirerId);
        return url;
    };

}

module.exports.TerminationInquiryHistoryService = TerminationInquiryHistoryService;

