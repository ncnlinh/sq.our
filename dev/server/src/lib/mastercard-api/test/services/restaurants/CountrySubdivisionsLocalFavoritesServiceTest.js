var testUtils = require('./../../utils/TestUtils');
var countrySubdivisionsLocalFavoritesServiceClass = require('../../../services/restaurants/CountrySubdivisionsLocalFavoritesService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('CountrySubdivisionsLocalFavoritesService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new countrySubdivisionsLocalFavoritesServiceClass.CountrySubdivisionsLocalFavoritesService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCountrySubdivisions()', function(){
        it('Retrieves Available Country Subdivisions', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert(response.CountrySubdivisions.CountrySubdivision.length > 0);
                done();
            });

            var options = {Country:"USA"};
            var account = service.getCountrySubdivisions(options);
        });
    })
});