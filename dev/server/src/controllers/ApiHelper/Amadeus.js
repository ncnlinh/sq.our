import Promise from 'bluebird';
import superagent from 'superagent';
import request from 'superagent-bluebird-promise';

import endpoint from './endpoint';
import key from '../../config/key';

const Amadeus = {
  services: {}
};


Amadeus.services.search = (origin, destination, departure_date, include_airlines=null, currency='SGD') => {
  const apikey = key.AMADEUS_API_KEY;
  const queryData = {apikey, origin, destination, departure_date, currency};
  include_airlines ? (queryData.include_airlines = include_airlines) : null;
  return request.post(endpoint.AMADEUS_SEARCH)
    .query(queryData)
    .then((res)=> {
      return Promise.resolve(JSON.parse(res.text));
    })
    .catch((error) => {
      console.log(error);
    });
};




export default Amadeus;

