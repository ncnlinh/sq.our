var testUtils = require('../../utils/TestUtils');
var terminationInquiryServiceClass = require('../../../services/match/TerminationInquiryService');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');
var irnUtil = require('../../../services/match/InquiryReferenceNumberUtil');

describe('TerminationInquiryService', function() {
    var service;
    beforeEach(function (done) {
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest();
        service = new terminationInquiryServiceClass.TerminationInquiryService(
            tu.getConsumerKey(),
            privateKey,
            environment.sandbox);
        done();
    });

    describe('#getTerminationInquiry()', function () {
        this.timeout(15000);
        it('Test TerminationInquiryService', function (done) {
            service.setCallback(function (response) {
                console.log(response);
                assert(response.TerminationInquiry.Ref != null);
                console.log("Ref = " + irnUtil.GetReferenceNumber(response.TerminationInquiry.Ref));
                assert(Number(irnUtil.GetReferenceNumber(response.TerminationInquiry.Ref)) > 0);
                assert(response.TerminationInquiry.TerminatedMerchant != null);
                done();
            });
            var request =
            {
                TerminationInquiryRequest: {
                    AcquirerId: acquirerId = "1996",
                    TransactionReferenceNumber: transactionReferenceNumber = "12345",
                    Merchant: {
                        Name: name = "TERMINATED MERCHANT 2",
                        DoingBusinessAsName: doingBusinessAsName = "DOING BUSINESS AS TERMINATED MERCHANT 2",
                        PhoneNumber: phoneNumber = "5555555555",
                        Address: {
                            Line1: line1 = "20 EAST MAIN ST",
                            Line2: line2 = "EAST ISLIP           NY",
                            City: city = "EAST ISLIP",
                            CountrySubdivision: countrySubdivision = "NY",
                            PostalCode: postalCode = "55555",
                            Country: country = "USA"
                        },
                        CountrySubdivisionTaxId: countrySubdivisionTaxId = "205545287",
                        NationalTaxId: nationalTaxId = "2891327625",
                        Principal: {
                            FirstName: firstName = "PATRICIA",
                            LastName: lastName = "CLARKE",
                            NationalId: nationalId = "",
                            PhoneNumber: phoneNumber = "5555555555",
                            Address: {
                                Line1: line1 = "93-52 243 STREET",
                                Line2: line2 = "",
                                City: city = "BELLEROSE",
                                CountrySubdivision: countrySubdivision = "NY",
                                PostalCode: postalCode = "55555-5555",
                                Country: country = "USA"
                            },
                            DriversLicense: {
                                Number: number = "",
                                CountrySubdivision: countrySubdivision = "",
                                Country: country = ""
                            }
                        }
                    }
                }
            };
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "10"
            };
            var terminationInquiry = service.getTerminationInquiry(request, options);
        });
    })
});