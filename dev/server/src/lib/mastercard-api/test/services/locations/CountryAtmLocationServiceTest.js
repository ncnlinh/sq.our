var testUtils = require('../../utils/TestUtils');
var countryAtmLocationServiceClass = require('../../../services/locations/atms/CountryAtmLocationService');
var environment = require('../../../common/Environment');
var assert = require('assert');

var util = require('util');

describe('CountryAtmLocationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest(environment.sandbox);
        service = new countryAtmLocationServiceClass.CountryAtmLocationService(
            tu.getConsumerKey(environment.sandbox),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCountries()', function() {
        it('Retrieve atm countries', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response != null);
                assert(response.Countries.Country.length > 0);
                done();
            });
            var countries = service.getCountries();
        });
    })
});