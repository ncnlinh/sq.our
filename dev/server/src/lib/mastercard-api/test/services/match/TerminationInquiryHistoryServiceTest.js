var testUtils = require('../../utils/TestUtils');
var terminationInquiryHistoryServiceClass = require('../../../services/match/TerminationInquiryHistoryService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');
var refUtil = require('../../../services/match/InquiryReferenceNumberUtil');

describe('TerminationInquiryHistoryService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new terminationInquiryHistoryServiceClass.TerminationInquiryHistoryService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getTerminationHistoryInquiry()', function () {
        this.timeout(15000);
        it('Test TerminationInquiryHistoryService', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(response.TerminationInquiry.TransactionReferenceNumber != null);
                assert(response.TerminationInquiry.TerminatedMerchant != null);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "10",
                AcquirerId: acquirerId = "1996",
                InquiryReferenceNumber: inquiryReferenceNumber = refUtil.GetReferenceNumber()
            };
            var terminationInquiry = service.getTerminationInquiry(request, options);
        });
    })
});