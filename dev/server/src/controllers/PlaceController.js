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

PlaceController.request.getPlaces = (req, res) => {
  PlaceController.promise.getPlaces(req)
    .then((places) => ResponseHelper.success(res, places))
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

PlaceController.promise.getPlaces = (req) => {
  const {facebookId, flightId} = req.body;
  return Promise.resolve(User.findOne({facebookId}))
    .then((user) => {
      const flight = user.flights.find((flight) => flight._id == flightId);
      return Promise.resolve(Place.find({yelpId: {
        $in: flight.likedPlaces
      }}));
    });
}

export default PlaceController;
