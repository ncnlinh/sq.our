var querystring = require('querystring');

addQueryParameter = function(url, descriptor, value){
  if (value) {
    url = url + '&' + descriptor + '=' + querystring.escape(value)
  }
  return url
};

exports.addQueryParameter = addQueryParameter;