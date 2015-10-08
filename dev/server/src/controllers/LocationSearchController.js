import Promise from 'bluebird';

import {ResponseHelper} from '../helpers';
import {Yelp} from './ApiHelper/';

const DEBUG_ENV = 'LocationSearchController';

const LocationSearchController = {
  request: {},
  promise: {}
};


LocationSearchController.request.search = (req, res) => {
  const {term, location, limit, offset} = req.body;
  return Yelp.services.search(term, location, limit, offset)
    .then((data) => ResponseHelper.success(res, data))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
}

export default LocationSearchController;