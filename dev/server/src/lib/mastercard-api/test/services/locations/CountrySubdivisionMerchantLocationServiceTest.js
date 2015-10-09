var testUtils = require('../../utils/TestUtils');
var countrySubdivisionMerchantLocationServiceClass = require('../../../services/locations/merchants/CountrySubdivisionMerchantLocationService');
var environment = require('../../../common/Environment');
var detailsClass = require('../../../services/locations/merchants/Details');
var assert = require('assert');

var util = require('util');

describe('CountrySubdivisionMerchantLocationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest(environment.sandbox);
        service = new countrySubdivisionMerchantLocationServiceClass.CountrySubdivisionMerchantLocationService(
            tu.getConsumerKey(environment.sandbox),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCountrySubdivisions()', function() {
        it('Retrieve merchant country subdivisions ACCEPTANCE_PAYPASS', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.CountrySubdivisions != null);
                assert(response.CountrySubdivisions.CountrySubdivision.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.acceptance_paypass,
                Country: country = "USA"
            };
            var countrySubdivisions = service.getCountrySubdivisions(options);
        });

        it('Retrieve merchant country subdivisions OFFERS_EASYSAVINGS', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.CountrySubdivisions != null);
                assert(response.CountrySubdivisions.CountrySubdivision.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.offers_easysavings,
                Country: country = "USA"
            };
            var countrySubdivisions = service.getCountrySubdivisions(options);
        });

        it('Retrieve merchant country subdivisions PRODUCTS_PREPAID_TRAVEL_CARD', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.CountrySubdivisions != null);
                assert(response.CountrySubdivisions.CountrySubdivision.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.products_prepaid_travel_card,
                Country: country = "USA"
            };
            var countrySubdivisions = service.getCountrySubdivisions(options);
        });

        it('Retrieve merchant country subdivisions TOPUP_REPOWER', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.CountrySubdivisions != null);
                assert(response.CountrySubdivisions.CountrySubdivision.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.topup_repower,
                Country: country = "USA"
            };
            var countrySubdivisions = service.getCountrySubdivisions(options);
        });
    })
});