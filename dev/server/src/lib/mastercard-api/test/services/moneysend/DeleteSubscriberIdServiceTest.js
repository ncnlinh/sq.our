var testUtils = require('../../utils/TestUtils');
var deleteSubscriberIdServiceClass = require('../../../services/moneysend/DeleteSubscriberIdService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');

describe('DeleteSubscriberIdService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new deleteSubscriberIdServiceClass.DeleteSubscriberIdService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getDeleteSubscriberId()', function () {
        this.timeout(15000);
        it('Delete a subscribers ID', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.DeleteSubscriberId.RequestId != null);
                assert(Number(response.DeleteSubscriberId.RequestId) > 0);
                done();
            });
            var request =
            {
                DeleteSubscriberIdRequest: {
                    SubscriberId: subscriberId = "exampleNodeReceiving@email.com",
                    SubscriberType: subscriberType = "EMAIL_ADDRESS"
                }
            };
            var deleteSubscriberId = service.getDeleteSubscriberId(request);
        });
    })
});