var testUtils = require('../../utils/TestUtils');
var countrySubdivisionAtmLocationServiceClass = require('../../../services/locations/atms/CountrySubdivisionAtmLocationService');
var environment = require('../../../common/Environment');
var assert = require('assert');

var util = require('util');

describe('CountrySubdivisionAtmLocationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest(environment.sandbox);
        service = new countrySubdivisionAtmLocationServiceClass.CountrySubdivisionAtmLocationService(
            tu.getConsumerKey(environment.sandbox),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCountrySubdivisions()', function() {
        it('Retrieve atm country subdivisions', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.CountrySubdivisions != null);
                assert(response.CountrySubdivisions.CountrySubdivision.length > 0);
                done();
            });
            var options =
            {
                Country: country = "USA"
            };
            var countrySubdivisions = service.getCountrySubdivisions(options);
        });
    })
});