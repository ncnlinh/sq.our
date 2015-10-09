var testUtils = require('./../../utils/TestUtils');
var restaurantsLocalFavoritesServiceClass = require('../../../services/restaurants/RestaurantsLocalFavoritesService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('RestaurantsLocalFavoritesService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new restaurantsLocalFavoritesServiceClass.RestaurantsLocalFavoritesService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getRestaurantsByLatLon()', function(){
        it('Retrieves Available Restaurants', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert(response.Restaurants.Restaurant.length > 0);
                done();
            });

            var options = {PageOffset:"0",PageLength:10,Latitude:38.53463,Longitude:-90.286781};
            var account = service.getRestaurants(options);
        });
    })
});