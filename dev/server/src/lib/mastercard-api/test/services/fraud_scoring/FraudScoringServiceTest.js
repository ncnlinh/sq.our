var testUtils = require('../../utils/TestUtils');
var fraudScoringServiceClass = require('../../../services/fraud_scoring/FraudScoringService');
var environment = require('../../../common/Environment');
var matchIndicatorStatus = require('../../../test/services/fraud_scoring/MatchIndicatorStatus');
var assert = require('assert');

describe('FraudScoringService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new fraudScoringServiceClass.FraudScoringService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getScoreLookup()', function () {
        this.timeout(15000);
        it('Test low fraud scoring single transaction match', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(matchIndicatorStatus.single_transaction_match == Number(response.ScoreLookup.ScoreResponse[0].MatchIndicator));
                done();
            });
            var request =
            {
                ScoreLookupRequest: {
                    TransactionDetail: {
                        CustomerIdentifier: customerIdentifier = "1996",
                        MerchantIdentifier: merchantIdentifier = "123",
                        AccountNumber: accountNumber = "5555555555555555555",
                        AccountPrefix: accountPrefix = "555555",
                        AccountSuffix: accountSuffix = "5555",
                        TransactionAmount: transactionAmount = "62500",
                        TransactionDate: transactionDate = "1231",
                        TransactionTime: transactionTime = "035959",
                        BankNetReferenceNumber: bankNetReferenceNumber = "abcABC123",
                        Stan: stan = "123456"
                    }
                }
            };
            var scoreLookup = service.getScoreLookup(request);
        });

        it('Test mid fraud scoring single transaction match', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(matchIndicatorStatus.multiple_trans_identical_card_match == Number(response.ScoreLookup.ScoreResponse[0].MatchIndicator));
                done();
            });
            var request =
            {
                ScoreLookupRequest: {
                    TransactionDetail: {
                        CustomerIdentifier: customerIdentifier = "1996",
                        MerchantIdentifier: merchantIdentifier = "123",
                        AccountNumber: accountNumber = "5555555555555555555",
                        AccountPrefix: accountPrefix = "555555",
                        AccountSuffix: accountSuffix = "5555",
                        TransactionAmount: transactionAmount = "10001",
                        TransactionDate: transactionDate = "1231",
                        TransactionTime: transactionTime = "035959",
                        BankNetReferenceNumber: bankNetReferenceNumber = "abcABC123",
                        Stan: stan = "123456"
                    }
                }
            };
            var scoreLookup = service.getScoreLookup(request);
        });

        it('Test high fraud scoring single transaction match', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(matchIndicatorStatus.multiple_trans_differing_cards_match == Number(response.ScoreLookup.ScoreResponse[0].MatchIndicator));
                done();
            });
            var request =
            {
                ScoreLookupRequest: {
                    TransactionDetail: {
                        CustomerIdentifier: customerIdentifier = "1996",
                        MerchantIdentifier: merchantIdentifier = "123",
                        AccountNumber: accountNumber = "5555555555555555555",
                        AccountPrefix: accountPrefix = "555555",
                        AccountSuffix: accountSuffix = "5555",
                        TransactionAmount: transactionAmount = "20001",
                        TransactionDate: transactionDate = "1231",
                        TransactionTime: transactionTime = "035959",
                        BankNetReferenceNumber: bankNetReferenceNumber = "abcABC123",
                        Stan: stan = "123456"
                    }
                }
            };
            var scoreLookup = service.getScoreLookup(request);
        });

        it('Test no match found', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(matchIndicatorStatus.no_match_found == Number(response.ScoreLookup.ScoreResponse[0].MatchIndicator));
                done();
            });
            var request =
            {
                ScoreLookupRequest: {
                    TransactionDetail: {
                        CustomerIdentifier: customerIdentifier = "1996",
                        MerchantIdentifier: merchantIdentifier = "123",
                        AccountNumber: accountNumber = "5555555555555555555",
                        AccountPrefix: accountPrefix = "555555",
                        AccountSuffix: accountSuffix = "5555",
                        TransactionAmount: transactionAmount = "30001",
                        TransactionDate: transactionDate = "1231",
                        TransactionTime: transactionTime = "035959",
                        BankNetReferenceNumber: bankNetReferenceNumber = "abcABC123",
                        Stan: stan = "123456"
                    }
                }
            };
            var scoreLookup = service.getScoreLookup(request);
        });
    })
});