var testUtils = require('../../utils/TestUtils');
var transferServiceClass = require('../../../services/moneysend/TransferService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');

describe('TransferService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new transferServiceClass.TransferService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getTransfer()', function () {
        this.timeout(15000);
//        it('Transfer money from a sending card account to a receiving card', function (done) {
//            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
////                console.log(response);
////                assert(Number(response.Transfer.TransactionReference) > 0);
////                assert(response.Transfer.TransactionHistory[0].Transaction != null);
////                assert(Number(response.Transfer.TransactionHistory[0].Transaction[0].Response[0].Code) == 0);
//                done();
//            });
//            var request =
//            {
//                TransferRequest: {
//                    LocalDate: localDate = "1212",
//                    LocalTime: localTime = "161222",
//                    TransactionReference: transactionReference = "1999999034810154901",
//                    SenderName: senderName = "John Doe",
//                    SenderAddress: {
//                        Line1: line1 = "123 Main Street",
//                        Line2: line2 = "#5A",
//                        City: city = "Arlington",
//                        CountrySubdivision: countrySubdivision = "VA",
//                        PostalCode: postalCode = "22207",
//                        Country: country = "USA"
//                    },
//                    FundingCard: {
//                        AccountNumber: accountNumber = "5184680430000006",
//                        ExpiryMonth: expiryMonth = "11",
//                        ExpiryYear: expiryYear = "2014"
//                    },
//                    FundingUCAF: fundingUCAF = "MjBjaGFyYWN0ZXJqdW5rVUNBRjU=1111",
//                    FundingMasterCardAssignedId: fundingMasterCardAssignedId = "123456",
//                    FundingAmount: {
//                        Value: value = "15500",
//                        Currency: currency = "840"
//                    },
//                    ReceiverName: receiverName = "Jose Lopez",
//                    ReceiverAddress: {
//                        Line1: line1 = "Pueblo Street",
//                        Line2: line2 = "PO BOX 12",
//                        City: city = "El PASO",
//                        CountrySubdivision: countrySubdivision = "TX",
//                        PostalCode: postalCode = "79906",
//                        Country: country = "USA"
//                    },
//                    ReceiverPhone: receiverPhone = "1800639426",
//                    ReceivingCard: {
//                        AccountNumber: accountNumber = "5184680430000006"
//                    },
//                    ReceivingAmount: {
//                        Value: value = "182206",
//                        Currency: currency = "484"
//                    },
//                    Channel: channel = "W",
//                    UCAFSupport: ucafSupport = "false",
//                    ICA: ica = "009674",
//                    ProcessorId: processorId = "9000000442",
//                    RoutingAndTransitNumber: routingAndTransitNumber = "990442082",
//                    CardAcceptor: {
//                        Name: name = "My Local Bank",
//                        City: city = "Saint Louis",
//                        State: state = "MO",
//                        PostalCode: postalCode = "63101",
//                        Country: country = "USA"
//                    },
//                    TransactionDesc: transactionDesc = "P2P",
//                    MerchantId: merchantId = "123456"
//                }
//            };
//            var transfer = service.getTransfer(request);
//        });

//        it('Transfer money from a sending mapped account to a receiving card', function (done) {
//            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
////                console.log(response);
////                assert(Number(response.Transfer.TransactionReference) > 0);
////                assert(response.Transfer.TransactionHistory[0].Transaction != null);
////                assert(Number(response.Transfer.TransactionHistory[0].Transaction[0].Response[0].Code) == 0);
//                done();
//            });
//            var request =
//            {
//                TransferRequest: {
//                    LocalDate: localDate = "1212",
//                    LocalTime: localTime = "161222",
//                    TransactionReference: transactionReference = "1999999034810154902",
//                    FundingMapped: {
//                        SubscriberId: subscriberId = "exampleNodeSending@email.com",
//                        SubscriberType: subscriberType = "EMAIL_ADDRESS",
//                        SubscriberAlias: subscriberAlias = "My Debit Card"
//                    },
//                    FundingUCAF: fundingUCAF = "MjBjaGFyYWN0ZXJqdW5rVUNBRjU=1111",
//                    FundingMasterCardAssignedId: fundingMasterCardAssignedId = "123456",
//                    FundingAmount: {
//                        Value: value = "15500",
//                        Currency: currency = "840"
//                    },
//                    ReceiverName: receiverName = "Jose Lopez",
//                    ReceiverAddress: {
//                        Line1: line1 = "Pueblo Street",
//                        Line2: line2 = "PO BOX 12",
//                        City: city = "El PASO",
//                        CountrySubdivision: countrySubdivision = "TX",
//                        PostalCode: postalCode = "79906",
//                        Country: country = "USA"
//                    },
//                    ReceiverPhone: receiverPhone = "1800639426",
//                    ReceivingCard: {
//                        AccountNumber: accountNumber = "5184680430000014"
//                    },
//                    ReceivingAmount: {
//                        Value: value = "182206",
//                        Currency: currency = "484"
//                    },
//                    Channel: channel = "W",
//                    UCAFSupport: ucafSupport = "false",
//                    ICA: ica = "009674",
//                    ProcessorId: processorId = "9000000442",
//                    RoutingAndTransitNumber: routingAndTransitNumber = "990442082",
//                    CardAcceptor: {
//                        Name: name = "My Local Bank",
//                        City: city = "Saint Louis",
//                        State: state = "MO",
//                        PostalCode: postalCode = "63101",
//                        Country: country = "USA"
//                    },
//                    TransactionDesc: transactionDesc = "P2P",
//                    MerchantId: merchantId = "123456"
//                }
//            };
//            var transfer = service.getTransfer(request);
//        });

//        it('On Us PaymentRequest to a receiving card', function (done) {
//            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
////                console.log(response);
////                assert(Number(response.Transfer.TransactionReference) > 0);
////                assert(response.Transfer.TransactionHistory[0].Transaction != null);
////                assert(Number(response.Transfer.TransactionHistory[0].Transaction[0].Response[0].Code) == 0);
//                done();
//            });
//            var request =
//            {
//                PaymentRequest: {
//                    LocalDate: localDate = "1212",
//                    LocalTime: localTime = "161222",
//                    TransactionReference: transactionReference = "1999999034810154903",
//                    SenderName: senderName = "John Doe",
//                    SenderAddress: {
//                        Line1: line1 = "123 Main Street",
//                        Line2: line2 = "#5A",
//                        City: city = "Arlington",
//                        CountrySubdivision: countrySubdivision = "VA",
//                        PostalCode: postalCode = "22207",
//                        Country: country = "USA"
//                    },
//                    ReceivingCard: {
//                        AccountNumber: accountNumber = "5184680430000014"
//                    },
//                    ReceivingAmount: {
//                        Value: value = "182206",
//                        Currency: currency = "484"
//                    },
//                    Channel: channel = "W",
//                    UCAFSupport: ucafSupport = "false",
//                    ICA: ica = "009674",
//                    ProcessorId: processorId = "9000000442",
//                    RoutingAndTransitNumber: routingAndTransitNumber = "990442082",
//                    CardAcceptor: {
//                        Name: name = "My Local Bank",
//                        City: city = "Saint Louis",
//                        State: state = "MO",
//                        PostalCode: postalCode = "63101",
//                        Country: country = "USA"
//                    },
//                    TransactionDesc: transactionDesc = "P2P",
//                    MerchantId: merchantId = "123456"
//                }
//            };
//            var transfer = service.getTransfer(request);
//        });

        it('On Us PaymentRequest to a receiving mapped account', function (done) {
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
                PaymentRequest: {
                    LocalDate: localDate = "1212",
                    LocalTime: localTime = "161222",
                    TransactionReference: transactionReference = "1999999034810154904",
                    SenderName: senderName = "John Doe",
                    SenderAddress: {
                        Line1: line1 = "123 Main Street",
                        Line2: line2 = "#5A",
                        City: city = "Arlington",
                        CountrySubdivision: countrySubdivision = "VA",
                        PostalCode: postalCode = "22207",
                        Country: country = "USA"
                    },
                    ReceivingMapped: {
                        SubscriberId: subscriberId = "exampleNodeReceiving@email.com",
                        SubscriberType: subscriberType = "EMAIL_ADDRESS",
                        SubscriberAlias: subscriberAlias = "My Debit Card"
                    },
                    ReceivingAmount: {
                        Value: value = "182206",
                        Currency: currency = "484"
                    },
                    Channel: channel = "W",
                    UCAFSupport: ucafSupport = "false",
                    ICA: ica = "009674",
                    ProcessorId: processorId = "9000000442",
                    RoutingAndTransitNumber: routingAndTransitNumber = "990442082",
                    CardAcceptor: {
                        Name: name = "My Local Bank",
                        City: city = "Saint Louis",
                        State: state = "MO",
                        PostalCode: postalCode = "63101",
                        Country: country = "USA"
                    },
                    TransactionDesc: transactionDesc = "P2P",
                    MerchantId: merchantId = "123456"
                }
            };
            var transfer = service.getTransfer(request);
        });

    })
});