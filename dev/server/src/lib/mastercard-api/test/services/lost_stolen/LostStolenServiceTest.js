var testUtils = require('./../../utils/TestUtils');
var lostStolenServiceClass = require('../../../services/lost_stolen/LostStolenService');
var environment = require('../../../common/Environment');
var assert = require('assert');

describe('LostStolenService', function(){
  var service;
  beforeEach(function(done){
    var tu = new testUtils.TestUtils();
    var privateKey = tu.generatePrivateKeyForTest();
    service = new lostStolenServiceClass.LostStolenService(
      tu.getConsumerKey(),
      privateKey,
      environment.sandbox);
    done();
  });

  describe('#getAccount()', function(){
    it('Retrieves Stolen Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('true' == response.Account.Listed[0]);
        assert('S' == response.Account.ReasonCode[0]);
        assert('STOLEN' == response.Account.Reason[0]);
        done();
      });
      var account = service.getAccount('5343434343434343');
    });

    it('Retrieves Fraud Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('true' == response.Account.Listed[0]);
        assert('F' == response.Account.ReasonCode[0]);
        assert('FRAUD' == response.Account.Reason[0]);
        done();
      });
      var account = service.getAccount('5105105105105100');
    });

    it('Retrieves Lost Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('true' == response.Account.Listed[0]);
        assert('L' == response.Account.ReasonCode[0]);
        assert('LOST' == response.Account.Reason[0]);
        done();
      });
      var account = service.getAccount('5222222222222200');
    });

    it('Retrieves Capture Card Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('true' == response.Account.Listed[0]);
        assert('P' == response.Account.ReasonCode[0]);
        assert('CAPTURE CARD' == response.Account.Reason[0]);
        done();
      });
      var account = service.getAccount('5305305305305300');
    });

    it('Retrieves Unauthorized Use Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('true' == response.Account.Listed[0]);
        assert('U' == response.Account.ReasonCode[0]);
        assert('UNAUTHORIZED USE' == response.Account.Reason[0]);
        done();
      });
      var account = service.getAccount('6011111111111117');
    });

    it('Retrieves Counterfeit Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('true' == response.Account.Listed[0]);
        assert('X' == response.Account.ReasonCode[0]);
        assert('COUNTERFEIT' == response.Account.Reason[0]);
        done();
      });
      var account = service.getAccount('4444333322221111');
    });

    it('Retrieves Unlisted Account Number', function(done){
      service.setCallback(function(response){
        console.log(response);
        assert('true' == response.Account.Status[0]);
        assert('false' == response.Account.Listed[0]);
        done();
      });
      var account = service.getAccount('343434343434343');
    });
  })
});