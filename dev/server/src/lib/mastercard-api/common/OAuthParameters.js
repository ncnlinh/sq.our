var NONCE_LENGTH = 8;
var VALID_CHARS = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';

var CRYPTO = require('crypto');

function OAuthParameters(consumerKey){
  this.consumerKey = consumerKey;
  this.timeStamp = _generateTimestamp();
  this.nonce = _generateNonce();
  this.signatureMethod = 'RSA-SHA1';
  this.oauthVersion = '1.0';
  this.bodyHash = '';
  this.signature = '';

  this.generateBodyHash = function(body){
    if (body){
      var shaSum = CRYPTO.createHash('sha1');
      shaSum.update(body, 'utf8');
      this.bodyHash = shaSum.digest('base64');
    }
  };

  this.generateParametersHash = function(){
    var ret = {
      oauth_consumer_key: this.consumerKey,
      oauth_timestamp: this.timeStamp.toString(),
      oauth_nonce: this.nonce,
      oauth_signature_method: this.signatureMethod,
      oauth_version: this.oauthVersion
    };
    if (this.bodyHash){
      ret.oauth_body_hash = this.bodyHash;
    }
    return ret;
  };

  this.addParameter = function(key, value){
    //todo
  };
}

var _generateTimestamp = function(){
  return Math. floor(new Date().getTime() / 1000);
};

var _generateNonce = function(){
  var rnd = CRYPTO.randomBytes(NONCE_LENGTH);
  var value = new Array(NONCE_LENGTH);
  var len = VALID_CHARS.length;

  for (var i = 0; i < NONCE_LENGTH; i++){
    value[i] = VALID_CHARS[rnd[i] % len];
  }

  return value.join('');
};

module.exports.OAuthParameters = OAuthParameters;
