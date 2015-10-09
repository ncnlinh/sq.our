var testUtilConstantsClass = require('../../test/utils/TestUtilConstants');
var environment = require('../../common/Environment');

function TestUtils(){
  this.generatePrivateKeyForTest = function(env){
        var pem;
        if (env == environment.production){
            pem = FS.readFileSync(testUtilConstantsClass.production_private_key_path);
        } else {
            pem = FS.readFileSync(testUtilConstantsClass.sandbox_private_key_path);
        }
        return pem.toString('utf8')
    };

  this.getConsumerKey = function(env){
      if (env == environment.production){
          return testUtilConstantsClass.production_consumer_key;
      } else {
          return testUtilConstantsClass.sandbox_consumer_key;
      }
  };

}

module.exports.TestUtils = TestUtils;