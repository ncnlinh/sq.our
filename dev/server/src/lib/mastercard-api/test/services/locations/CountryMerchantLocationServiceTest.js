var testUtils = require('../../utils/TestUtils');
var countryMerchantLocationServiceClass = require('../../../services/locations/merchants/CountryMerchantLocationService');
var environment = require('../../../common/Environment');
var detailsClass = require('../../../services/locations/merchants/Details');
var assert = require('assert');

var util = require('util');

describe('CountryMerchantLocationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest(environment.sandbox);
        service = new countryMerchantLocationServiceClass.CountryMerchantLocationService(
            tu.getConsumerKey(environment.sandbox),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCountries()', function() {
        it('Retrieve merchant countries', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response != null);
                assert(response.Countries.Country.length > 0);
                done();
            });
            var options =
            {
                Details: details = detailsClass.acceptance_paypass
            };
            var countries = service.getCountries(options);
        });
    })
});