var testUtils = require('./../../utils/TestUtils');
var categoriesLocalFavoritesServiceClass = require('../../../services/restaurants/CategoriesLocalFavoritesService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('CategoriesLocalFavoritesService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new categoriesLocalFavoritesServiceClass.CategoriesLocalFavoritesService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCategories()', function(){
        it('Retrieves Available Categories', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert(response.Categories.Category[0] == 'AMERICAN');
                assert(response.Categories.Category.length > 0);
                done();
            });
            var account = service.getCategories();
        });
    })
});