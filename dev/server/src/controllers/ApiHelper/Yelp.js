import Promise from 'bluebird';
import superagent from 'superagent';
import request from 'superagent-bluebird-promise';
import oauthSignature from 'oauth-signature';
import _ from 'lodash';
require('superagent-oauth')(request);

import endpoint from './endpoint';
import key from '../../config/key';

const Yelp = {
  services: {}
};
const randomString = (length) => {
    let text = "";
    const possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for(var i = 0; i < length; i++) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
    }
    return text;
}

const consumerSecret = key.YELP_CONSUMER_SECRET;
const tokenSecret = key.YELP_TOKEN_SECRET;

Yelp.services.search = (term, location, limit, offset) => {
  const oauth = {
    oauth_consumer_key: key.YELP_CONSUMER_KEY,
    oauth_token: key.YELP_TOKEN,
    oauth_nonce: randomString(32),
    oauth_timestamp: new Date().getTime(),
    oauth_signature_method : 'HMAC-SHA1',
    oauth_version : '1.0'
  }
  const queryData = {term, location, limit, offset};
  const url = endpoint.YELP_SEARCH;
  // const encodedSignature = oauthSignature.generate('GET', url, _.extend(oauth, queryData) , consumerSecret, tokenSecret),
  const signature = oauthSignature.generate('GET', url, _.extend(oauth, queryData), consumerSecret, tokenSecret,
        { encodeSignature: false});
  const queryParameter = _.extend(oauth, queryData, {oauth_signature: signature});
  return request.get(url)
    .query(queryParameter)
    .then((res)=> {
      return JSON.parse(res.text);
    });
};

export default Yelp;

