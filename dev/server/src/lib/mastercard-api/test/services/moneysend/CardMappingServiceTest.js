var testUtils = require('../../utils/TestUtils');
var cardMappingServiceClass = require('../../../services/moneysend/CardMappingService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');

describe('CardMappingService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new cardMappingServiceClass.CardMappingService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getCreateMapping()', function () {
        this.timeout(15000);
        it('Create a new card mapping', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(response.CreateMapping.RequestId != null);
                assert(Number(response.CreateMapping.RequestId) > 0);
                done();
            });
            var request =
            {
                CreateMappingRequest: {
                    SubscriberId: subscriberId = "exampleNodeSending@email.com",
                    SubscriberType: subscriberType = "EMAIL_ADDRESS",
                    AccountUsage: accountUsage = "SENDING",
                    DefaultIndicator: defaultIndicator = "T",
                    Alias: alias = "My Debit Card",
                    ICA: ica = "009674",
                    AccountNumber: accountNumber = "5184680430000006",
                    ExpiryDate: expiryDate = "201409",
                    CardholderFullName: {
                        CardholderFirstName: cardholderFirstName = "John",
                        CardholderMiddleName: cardholderMiddleName = "Q",
                        CardholderLastName: cardholderLastName = "Public"
                    },
                    Address: {
                        Line1: line1 = "123 Main Street",
                        Line2: line2 = "#5A",
                        City: city = "OFallon",
                        CountrySubdivision: countrySubdivision = "MO",
                        PostalCode: postalCode = "63368",
                        Country: country = "USA"
                    },
                    DateOfBirth: dateOfBirth = "19460102"
                }
            };
            var createMapping = service.getCreateMapping(request);
        });
    });

//    describe('#getInquireMapping()', function () {
//        this.timeout(15000);
//        it('Inquire account mapping details', function (done) {
//            service.setCallback(function (response) {
////                console.log(util.inspect(response, false, null));
//                console.log(response);
//                assert(response.InquireMapping.RequestId != null);
//                assert(Number(response.InquireMapping.RequestId) > 0);
//                assert(response.InquireMapping.Mappings[0].Mapping[0].MappingId != null);
//                assert(Number(response.InquireMapping.Mappings[0].Mapping[0].MappingId) > 0);
//                done();
//            });
//            var request =
//            {
//                InquireMappingRequest: {
//                    SubscriberId: subscriberId = "exampleNodeReceiving@email.com",
//                    SubscriberType: subscriberType = "EMAIL_ADDRESS",
//                    AccountUsage: accountUsage = "RECEIVING",
//                    Alias: alias = "My Debit Card",
//                    DataResponseFlag: dataResponseFlag = "3"
//                }
//            };
//            var inquireMapping = service.getInquireMapping(request);
//        });
//    });
//
//    describe('#getUpdateMapping()', function () {
//        this.timeout(15000);
//        var mapping_id = "";
//        it('Update a previously created mapping', function (done) {
//            service.setCallback(function (response) {
//                console.log(response);
//                assert(response.UpdateMapping.RequestId != null);
//                assert(Number(response.UpdateMapping.RequestId) > 0);
//                service.setCallback(function (response) {
//                    console.log(response.InquireMapping.Mappings[0].Mapping[0].MappingId);
//                    mapping_id = response.InquireMapping.Mappings[0].Mapping[0].MappingId;
//                    done();
//                });
//                done();
//            });
//            var inquireRequest =
//            {
//                InquireMappingRequest: {
//                    SubscriberId: subscriberId = "exampleNodeReceiving@email.com",
//                    SubscriberType: subscriberType = "EMAIL_ADDRESS",
//                    AccountUsage: accountUsage = "RECEIVING",
//                    Alias: alias = "My Debit Card",
//                    DataResponseFlag: dataResponseFlag = "3"
//                }
//            };
//            var inquireMapping = service.getInquireMapping(inquireRequest);
//            var request =
//            {
//                UpdateMappingRequest: {
//                    SubscriberId: subscriberId = "exampleNodeReceiving@email.com",
//                    SubscriberType: subscriberType = "EMAIL_ADDRESS",
//                    AccountUsage: accountUsage = "RECEIVING",
//                    DefaultIndicator: defaultIndicator = "T",
//                    Alias: alias = "The Debit Card",
//                    ICA: ica = "009674",
//                    AccountNumber: accountNumber = "5184680430000014",
//                    ExpiryDate: expiryDate = "201409",
//                    CardholderFullName: {
//                        CardholderFirstName: cardholderFirstName = "John",
//                        CardholderMiddleName: cardholderMiddleName = "X",
//                        CardholderLastName: cardholderLastName = "Public"
//                    },
//                    Address: {
//                        Line1: line1 = "123 Main Street",
//                        Line2: line2 = "#5A",
//                        City: city = "OFallon",
//                        CountrySubdivision: countrySubdivision = "MO",
//                        PostalCode: postalCode = "63368",
//                        Country: country = "USA"
//                    },
//                    DateOfBirth: dateOfBirth = "19460102"
//                }
//            };
//            var options =
//            {
//                MappingId: mappingId = mapping_id
//            };
//
//            var updateMapping = service.getUpdateMapping(request, options);
//        });
//    });
//
//    describe('#getDeleteMapping()', function () {
//        this.timeout(15000);
//        var mapping_id = "";
//        it('Delete a previously created mapping', function (done) {
//            service.setCallback(function (response) {
//                console.log(response);
//                assert(response.DeleteMapping.RequestId != null);
//                assert(Number(response.DeleteMapping.RequestId) > 0);
//                assert(response.DeleteMapping.Mappings[0].Mapping[0].MappingId != null);
//                assert(Number(response.DeleteMapping.Mappings[0].Mapping[0].MappingId) > 0);
//                done();
//            });
//            var options =
//            {
//                MappingId: mappingId = "16602"
//            };
//            var deleteMapping = service.getDeleteMapping(options);
//        });
//    })
});