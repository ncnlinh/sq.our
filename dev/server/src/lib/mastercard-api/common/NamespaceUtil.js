var JSXML = require("node-jsxml");

var Namespace = JSXML.Namespace,
    XML = JSXML.XML;
var terminationNS = new Namespace("ns2", "http://mastercard.com/termination");


function AddNamespace(body) {
    if (body.indexOf("TerminationInquiryRequest") > -1) {
        body = body.replace("<TerminationInquiryRequest", "<ns2:TerminationInquiryRequest");
        body = body.replace("</TerminationInquiryRequest", "</ns2:TerminationInquiryRequest");
        var xmlBody = new XML(body);
        xmlBody.addNamespace(terminationNS);
        xmlBody = xmlBody.toXMLString();
        return xmlBody;
    } else {
        return body;
    }
}

function RemoveNamespace(body) {
    if (body.indexOf("ns2:") > -1) {
        body = body.replace("ns2:", "");
        body = body.replace("/ns2:", "/");
        var xmlBody = new XML(body);
        xmlBody.removeNamespace(terminationNS);
        xmlBody = xmlBody.toXMLString();
        return xmlBody;
    } else {
        return body;
    }
}

module.exports.AddNamespace = AddNamespace;
module.exports.RemoveNamespace = RemoveNamespace;