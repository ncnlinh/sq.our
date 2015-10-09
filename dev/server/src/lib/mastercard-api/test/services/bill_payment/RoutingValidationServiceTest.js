var testUtils = require('../../utils/TestUtils');
var routingValidationServiceClass = require('../../../services/bill_payment/RoutingValidationService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('RoutingValidationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new routingValidationServiceClass.RoutingValidationService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getBillPayAccountValidation()', function(){
        this.timeout(15000);
        it('Successful BillPayAccountValidation', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert('Successful' == response.BillPayAccountValidation.ResponseString);
                done();
            });
            var request =
            {
                BillPayAccountValidation: {
                    RppsId: rppsId = "99887761",
                    BillerId: billerId = "9998887771",
                    AccountNumber: accountNumber = "1234567890",
                    TransactionAmount: transactionAmount = "250.00",
                    CustomerIdentifier1: customerIdentifier1 = "",
                    CustomerIdentifier2: customerIdentifier2 = "",
                    CustomerIdentifier3: customerIdentifier3 = "",
                    CustomerIdentifier4: customerIdentifier4 = "",
                    ResponseString: responseString = ""
                }
            };
            var billPayAccountValidationResponse = service.getBillPayAccountValidation(request);
        });

        it('Invalid RPPSID', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert('Invalid RPPSID' == response.BillPayAccountValidation.ResponseString);
                done();
            });
            var request =
            {
                BillPayAccountValidation: {
                    RppsId: rppsId = "00000000",
                    BillerId: billerId = "9998887770",
                    AccountNumber: accountNumber = "1234567890",
                    TransactionAmount: transactionAmount = "250.00",
                    CustomerIdentifier1: customerIdentifier1 = "",
                    CustomerIdentifier2: customerIdentifier2 = "",
                    CustomerIdentifier3: customerIdentifier3 = "",
                    CustomerIdentifier4: customerIdentifier4 = "",
                    ResponseString: responseString = ""
                }
            };
            var billPayAccountValidationResponse = service.getBillPayAccountValidation(request);
        });

        it('Incative RPPSID', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert('RPPSID is not active' == response.BillPayAccountValidation.ResponseString);
                done();
            });
            var request =
            {
                BillPayAccountValidation: {
                    RppsId: rppsId = "99887760",
                    BillerId: billerId = "9998887770",
                    AccountNumber: accountNumber = "1234567890",
                    TransactionAmount: transactionAmount = "250.00",
                    CustomerIdentifier1: customerIdentifier1 = "",
                    CustomerIdentifier2: customerIdentifier2 = "",
                    CustomerIdentifier3: customerIdentifier3 = "",
                    CustomerIdentifier4: customerIdentifier4 = "",
                    ResponseString: responseString = ""
                }
            };
            var billPayAccountValidationResponse = service.getBillPayAccountValidation(request);
        });

        it('Invalid BillerID', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert('Invalid BillerID' == response.BillPayAccountValidation.ResponseString);
                done();
            });
            var request =
            {
                BillPayAccountValidation: {
                    RppsId: rppsId = "99887761",
                    BillerId: billerId = "0000000000",
                    AccountNumber: accountNumber = "1234567890",
                    TransactionAmount: transactionAmount = "250.00",
                    CustomerIdentifier1: customerIdentifier1 = "",
                    CustomerIdentifier2: customerIdentifier2 = "",
                    CustomerIdentifier3: customerIdentifier3 = "",
                    CustomerIdentifier4: customerIdentifier4 = "",
                    ResponseString: responseString = ""
                }
            };
            var billPayAccountValidationResponse = service.getBillPayAccountValidation(request);
        });

        it('Inactive BillerID', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert('BillerID is not active' == response.BillPayAccountValidation.ResponseString);
                done();
            });
            var request =
            {
                BillPayAccountValidation: {
                    RppsId: rppsId = "99887761",
                    BillerId: billerId = "9998887772",
                    AccountNumber: accountNumber = "1234567890",
                    TransactionAmount: transactionAmount = "250.00",
                    CustomerIdentifier1: customerIdentifier1 = "",
                    CustomerIdentifier2: customerIdentifier2 = "",
                    CustomerIdentifier3: customerIdentifier3 = "",
                    CustomerIdentifier4: customerIdentifier4 = "",
                    ResponseString: responseString = ""
                }
            };
            var billPayAccountValidationResponse = service.getBillPayAccountValidation(request);
        });

        it('Exceeds Transaction Amount', function(done){
            service.setCallback(function(response){
                console.log(response);
                assert('Transaction Amount exceeds BillerID maximum' == response.BillPayAccountValidation.ResponseString);
                done();
            });
            var request =
            {
                BillPayAccountValidation: {
                    RppsId: rppsId = "99887761",
                    BillerId: billerId = "9998887771",
                    AccountNumber: accountNumber = "1234567890",
                    TransactionAmount: transactionAmount = "5000.00",
                    CustomerIdentifier1: customerIdentifier1 = "",
                    CustomerIdentifier2: customerIdentifier2 = "",
                    CustomerIdentifier3: customerIdentifier3 = "",
                    CustomerIdentifier4: customerIdentifier4 = "",
                    ResponseString: responseString = ""
                }
            };
            var billPayAccountValidationResponse = service.getBillPayAccountValidation(request);
        });
    })
});