var testUtils = require('../../utils/TestUtils');
var transferReversalServiceClass = require('../../../services/moneysend/TransferReversalService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');

describe('TransferReversalService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new transferReversalServiceClass.TransferReversalService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getTransferReversal()', function () {
        this.timeout(15000);
        it('Reverse a previous TransferRequest', function (done) {
            service.setCallback(function (response) {
                console.log(util.inspect(response, false, null));
//                console.log(response);
//                assert(Number(response.Transfer.TransactionReference) > 0);
//                assert(response.Transfer.TransactionHistory[0].Transaction != null);
//                assert(Number(response.Transfer.TransactionHistory[0].Transaction[0].Response[0].Code) == 0);
                done();
            });
            var request =
            {
                TransferReversalRequest: {
                    ICA: ica = "009674",
                    TransactionReference: transactionReference = "1999999034810154904",
                    ReversalReason: reversalReason = "FAILURE IN PROCESSING"
                }
            };
            var transferReversal = service.getTransferReversal(request);
        });
    })
});