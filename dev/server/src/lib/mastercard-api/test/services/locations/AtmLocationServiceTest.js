var testUtils = require('../../utils/TestUtils');
var atmLocationServiceClass = require('../../../services/locations/atms/AtmLocationService');
var atmConstantsClass = require('../../../services/locations/atms/AtmConstants');
var environment = require('../../../common/Environment');
var assert = require('assert');
var util = require('util');



describe('AtmLocationService', function(){
    var service;
    beforeEach(function(done){
        var tu = new testUtils.TestUtils();
        var privateKey = tu.generatePrivateKeyForTest(environment.production);
        service = new atmLocationServiceClass.AtmLocationService(
            tu.getConsumerKey(environment.production),
            privateKey,
            environment.production);
        done();
    });

    describe('#getAtms()', function() {
        this.timeout(15000);
        it('Retrieve atm locations by numeric postal code', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                PostalCode: postalCode = "46320"
            };
            var atms = service.getAtms(options);
        });

        it('Retrieve atm locations by foreign postal code', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "SGP",
                PostalCode: postalCode = "068897"
            };
            var atms = service.getAtms(options);
        });

        it('Retrieve atm locations by latitude longitude', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Radius: radius = "5",
                DistanceUnit: distanceUnit = atmConstantsClass.kilometer,
                Latitude: latitude = "1.2833",
                Longitude: longitude = "103.8499"
            };
            var atms = service.getAtms(options);
        });

        it('Retrieve atm locations by address', function (done) {
            service.setCallback(function (response) {
                console.log(util.inspect(response, false, null));
//                console.log(response);
//                assert(null != response);
//                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "SGP",
                AddressLine1: addressLine1 = "BLK 1 ROCHOR ROAD UNIT 01-640 ROCHOR ROAD"
            };
            var atms = service.getAtms(options);
        });

        it('Retrieve atm locations by city', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                City: city = "CHICAGO"
            };
            var atms = service.getAtms(options);
        });

        it('Retrieve atm locations by country subdivision', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Country: country = "USA",
                COuntrySubdivision: countrySubdivision = "IL"
            };
            var atms = service.getAtms(options);
        });

        it('Retrieve atm locations by SUPPORT_EMV_YES', function (done) {
            service.setCallback(function (response) {
//                console.log(util.inspect(response, false, null));
                console.log(response);
                assert(null != response);
                assert(0 < response.Atms.Atm.length);
                done();
            });
            var options =
            {
                SupportEMV: supportEmv = atmConstantsClass.suppory_emv_yes,
                PageOffset: pageOffset = "0",
                PageLength: pageLength = "25",
                Latitude: latitude = "1.2833",
                Longitude: longitude = "103.8499"
            };
            var atms = service.getAtms(options);
        });
    })
});