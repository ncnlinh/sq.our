import Promise from 'bluebird';
import _ from 'lodash';
import {MongooseHelper, ResponseHelper} from '../helpers';
import {User, Place} from '../models';

const DEBUG_ENV = 'PlaceController';

const PlaceController = {
  request: {},
  promise: {}
};

PlaceController.request.queryAndCreate = (req, res) => {
  PlaceController.promise.queryAndCreate(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

PlaceController.promise.queryAndCreate = (req, res) => {
  const {location, name, imageUrl, address, yelpId, description, latitude, longitude} = req.body;
  return Promise.resolve(Place.findOne({yelpId}).exec())
    .then(MongooseHelper.checkExists)
    .catch(() => {
      return MongooseHelper.create(Place, {location, name, imageUrl, address, yelpId, description, latitude, longitude});
    })
};

export default PlaceController;
