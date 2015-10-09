var testUtils = require('../../utils/TestUtils');
var merchantIdentifierServiceClass = require('../../../services/merchant_identifier/MerchantIdentifierService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('MerchantIdentifierService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new merchantIdentifierServiceClass.MerchantIdentifierService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getMerchantIds()', function() {
        this.timeout(15000);
        it('Retrieve merchant ids no Type', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(null != response.MerchantIds.ReturnedMerchants);
                assert(null != response.MerchantIds.Message);
                done();
            });
            var options =
            {
                MerchantId: merchantId = "DIRECTSATELLITETV"
            };
            var merchantIds = service.getMerchantIds(options);
        });

        it('Retrieve merchant ids EXACTMATCH', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(null != response.MerchantIds.ReturnedMerchants);
                assert(null != response.MerchantIds.Message);
                done();
            });
            var options =
            {
                MerchantId: merchantId = "DIRECTSATELLITETV",
                Type: type = "ExactMatch"
            };
            var merchantIds = service.getMerchantIds(options);
        });

        it('Retrieve merchant ids FUZZYMATCH', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(null != response.MerchantIds.ReturnedMerchants);
                assert(null != response.MerchantIds.Message);
                done();
            });
            var options =
            {
                MerchantId: merchantId = "DIRECTSATELLITETV",
                Type: type = "FuzzyMatch"
            };
            var merchantIds = service.getMerchantIds(options);
        });
    })
});