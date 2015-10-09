var testUtils = require('./../../utils/TestUtils');
var countriesLocalFavoritesServiceClass = require('../../../services/restaurants/CountriesLocalFavoritesService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('CountriesLocalFavoritesService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new countriesLocalFavoritesServiceClass.CountriesLocalFavoritesService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCountries()', function(){
        it('Retrieves Available Countries', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert(response.Countries.Country.length > 0);
                done();
            });
            var account = service.getCountries();
        });
    })
});