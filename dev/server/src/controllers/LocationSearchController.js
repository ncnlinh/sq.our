import Promise from 'bluebird';

import {ResponseHelper} from '../helpers';
import {Yelp} from './ApiHelper/';

const DEBUG_ENV = 'LocationSearchController';

const LocationSearchController = {
  request: {},
  promise: {}
};


LocationSearchController.request.search = (req, res) => {
  const {term, location, limit, offset, categoryFilter} = req.body;
  return Yelp.services.search(term, location, limit, offset, categoryFilter)
    .then((data) => {
      data = data.businesses.map((business) => {
        let placeData = {}
        placeData.name = business.name;
        placeData.imageUrl = business.image_url ? business.image_url.replace('ms.jpg','o.jpg') : null;
        placeData.location = business.location ? business.location.city : null;
        placeData.address = business.location ? business.location.address : null;
        placeData.latitude = (business.location && business.location.coordinate) ? business.location.coordinate.latitude : null;
        placeData.longitude = (business.location && business.location.coordinate) ? business.location.coordinate.longitude : null;
        placeData.yelpId = business.id;
        placeData.description = business.snippet_text;

        return placeData;
      });
      ResponseHelper.success(res, data)
    })
    .catch((error) => {
      ResponseHelper.error(res, error, DEBUG_ENV)
    });
}

export default LocationSearchController;