var testUtils = require('../../utils/TestUtils');
var repowerServiceClass = require('../../../services/repower/repower/RepowerService');
var repowerReversalServiceClass = require('../../../services/repower/repower_reversal/RepowerReversalService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');
var tranRef = 2997999034810154995;

//describe('RepowerService', function() {
//    var service;
//    beforeEach(function (done) {
//        var tu = new testUtils.TestUtils();
//        var privateKey = tu.generatePrivateKeyForTest();
//        service = new repowerServiceClass.RepowerService(
//            tu.getConsumerKey(),
//            privateKey,
//            environment.sandbox);
//        done();
//    });

//    describe('#getRepower()', function () {
//        this.timeout(15000);
//        it('Successful Repower', function (done) {
//            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
////                console.log(response);
////                assert(response.Repower.RequestId != null);
//                done();
//            });
//            var request =
//            {
//                RepowerRequest: {
//                    TransactionReference: transactionReference = 2999999034810154995,
//                    CardNumber: cardNumber = "5184680430000006",
//                    TransactionAmount: {
//                        Value: value = "30000",
//                        Currency: currency = "840"
//                    },
//                    LocalDate: localTime = "1230",
//                    LocalTime: localTime = "092435",
//                    Channel: channel = "W",
//                    ICA: ica = "009674",
//                    ProcessorId: processorId = "9000000442",
//                    RoutingAndTransitNumber: routingAndTransitNumber = "990442082",
//                    MerchantType: merchantType = "6532",
//                    CardAcceptor: {
//                        Name: name = "Prepaid Load Store",
//                        City: city = "St Charles",
//                        State: state = "MO",
//                        PostalCode: postalCode = "63301",
//                        Country: country = "USA"
//                    }
//                }
//            };
//            var repower = service.getRepower(request);
//        });
//    })
//});

describe('RepowerReversalService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new repowerReversalServiceClass.RepowerReversalService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getRepowerReversal()', function () {
        this.timeout(15000);
        it('Successful RepowerReversal', function (done) {
            service.setCallback(function (response) {
                console.log(util.inspect(response, false, null));
//                console.log(response);
//                assert(response.RepowerReversal.RequestId != null);
//                assert(Number(response.RepowerReversal.TransactionHistory.Transaction.Response.Code) == 0);
                done();
            });
            var request =
            {
                RepowerReversalRequest: {
                    ICA: ica = "009674",
                    TransactionReference: transactionReference = 2999999034810154995,
                    ReversalReason: reversalReason = "UNIT TEST"
                }
            };
            var repowerReversal = service.getRepowerReversal(request);
        });
    })
});