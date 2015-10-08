import Promise from 'bluebird';
import superagent from 'superagent';
import request from 'superagent-bluebird-promise';

import endpoint from './endpoint';
import key from '../../config/key';

const Amadeus = {
  services: {}
};


Amadeus.services.search = (origin, destination, departure_date, include_airlines, currency) => {
  const apikey = key.AMADEUS_API_KEY;
  const queryData = {apikey, origin, destination, departure_date, include_airlines, currency};
  return request.post(endpoint.AMADEUS_SEARCH)
    .query(queryData)
    .then((res)=> {
      return JSON.parse(res.text);
    });
};




export default Amadeus;

