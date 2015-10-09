var testUtils = require('../../utils/TestUtils');
var merchantLocationServiceClass = require('../../../services/locations/merchants/MerchantLocationService');
var detailsClass = require('../../../services/locations/merchants/Details');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');



describe('MerchantLocationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest(environment.production);
        service = new merchantLocationServiceClass.MerchantLocationService(
            tu.getConsumerKey(environment.production),
            privateKey,
            environment.production);
        done();
    });

    describe('#getMerchants()', function() {
        this.timeout(15000);
        it('Retrieve merchant locations TOPUP_REPOWER', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Merchants.Merchant.length);
                assert(0 < Number(response.Merchants.Merchant[0].Id[0]));
                done();
            });
            var options =
            {
                Details: details = detailsClass.topup_repower,
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                PostalCode: postalCode = "22122"
            };
            var merchants = service.getMerchants(options);
        });

        // valid results. Passing of this test implies that PPTC has begun to return
        // valid results and that no SDK changes are needed.
//        it('Retrieve merchant locations PRODUCTS_PREPAID_TRAVEL_CARD - fail', function (done) {
//            service.setCallback(function (response) {
////                console.log(util.inspect(response, false, null));
//                console.log(response);
//                assert(null != response.Merchants.Merchant);
//                assert(0 < response.Merchants.Merchant.length);
//                done();
//            });
//            var options =
//            {
//                Details: details = detailsClass.products_prepaid_travel_card,
//                PageOffset: pageOffset = "0",
//                PageLength: pageLength = "25",
//                Country: country = "USA",
//                PostalCode: postalCode = 20006
//            };
//            var merchants = service.getMerchants(options);
//        });

        it('Retrieve merchant locations PRODUCTS_PREPAID_TRAVEL_CARD - pass', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response != null);
                assert(response.Merchants.Merchant == null);
                done();
            });
            var options =
            {
                Details: details = detailsClass.products_prepaid_travel_card,
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                PostalCode: postalCode = "20006"
            };
            var merchants = service.getMerchants(options);
        });

        it('Retrieve merchant locations OFFERS_EASYSAVINGS', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response != null);
                assert(response.Merchants.Merchant.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.offers_easysavings,
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                PostalCode: postalCode = "22122"
            };
            var merchants = service.getMerchants(options);
        });

        it('Retrieve merchant locations ACCEPTANCE_PAYPASS', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response != null);
                assert(response.Merchants.Merchant.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.acceptance_paypass,
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                PostalCode: postalCode = "07032"
            };
            var merchants = service.getMerchants(options);
        });

        it('Retrieve merchant locations FEATURES_CASHBACK', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response != null);
                assert(response.Merchants.Merchant.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.features_cashback,
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                PostalCode: postalCode = "46323"
            };
            var merchants = service.getMerchants(options);
        });
    })
});