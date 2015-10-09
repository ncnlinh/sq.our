var testUtils = require('../../utils/TestUtils');
var merchantCategoriesServiceClass = require('../../../services/locations/merchants/MerchantCategoriesService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('MerchantCategoriesService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new merchantCategoriesServiceClass.MerchantCategoriesService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCategories()', function() {
        it('Retrieve merchant categories', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(null != response);
                assert(0 < response.Categories.Category.length);
                done();
            });
            var categories = service.getCategories();
        });
    })
});