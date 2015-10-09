var testUtils = require('../../utils/TestUtils');
var panEligibilityServiceClass = require('../../../services/moneysend/PanEligibilityService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');

describe('PanEligibilityService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new panEligibilityServiceClass.PanEligibilityService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getPanEligibility()', function () {
        this.timeout(15000);
        it('Determine if an account number is eligible for sending and receiving - true', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.PanEligibility.SendingEligibility[0].Eligible == 'true');
                assert(response.PanEligibility.ReceivingEligibility[0].Eligible == 'true');
                done();
            });
            var request =
            {
                PanEligibilityRequest: {
                    SendingAccountNumber: sendingAccountNumber = "5184680430000006",
                    ReceivingAccountNumber: receivingAccountNumber = "5184680430000006"
                }
            };
            var panEligibility = service.getPanEligibility(request);
        });

        it('Determine if an account number is eligible for sending - false', function (done) {
            setTimeout(done, 15000);
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.PanEligibility.SendingEligibility[0].Eligible == 'false');
                done();
            });
            var request =
            {
                PanEligibilityRequest: {
                    SendingAccountNumber: sendingAccountNumber = "5184680990000024"
                }
            };
            var panEligibility = service.getPanEligibility(request);
        });

        it('Determine if an account number is eligible for sending - false', function (done) {
            setTimeout(done, 15000);
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(response.PanEligibility.ReceivingEligibility[0].Eligible == 'false');
                done();
            });
            var request =
            {
                PanEligibilityRequest: {
                    ReceivingAccountNumber: receivingAccountNumber = "5184680060000201"
                }
            };
            var panEligibility = service.getPanEligibility(request);
        });
    })
});