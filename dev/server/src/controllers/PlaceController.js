import Promise from 'bluebird';
import _ from 'lodash';
import {MongooseHelper, ResponseHelper} from '../helpers';
import {User, Place} from '../models';

const DEBUG_ENV = 'PlaceController';

const PlaceController = {
  request: {},
  promise: {}
};


PlaceController.request.get = (req, res) => {
  PlaceController.promise.get(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

PlaceController.request.getAll = (req, res) => {
  PlaceController.promise.getAll(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

PlaceController.request.query = (req, res) => {
  PlaceController.promise.query(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

PlaceController.request.queryAndCreate = (req, res) => {
  PlaceController.promise.queryAndCreate(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

PlaceController.request.addUser = (req, res) => {
  PlaceController.promise.addUser(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
  
 
PlaceController.promise.get = (req, res) => {
  const {_id} = req.body;
  return Promise.resolve(Place.findOne({_id}).exec())
    .then(MongooseHelper.checkExists)
};

PlaceController.promise.getAll = (req, res) => {
  const {_id} = req.body;
  return Promise.resolve(Place.find().exec())
    .then(MongooseHelper.checkExists)
};

PlaceController.promise.query = (req, res) => {
  const {location, name, category} = req.body;
  return Promise.resolve(Place.findOne({location, name, category}).exec())
    .then(MongooseHelper.checkExists)
};

PlaceController.promise.queryAndCreate = (req, res) => {
  const {location, name, category, description, lat, lon} = req.body;
  return Promise.resolve(Place.findOne({location, name, category}).exec())
    .then(MongooseHelper.checkExists)
    .catch(() => {
      return MongooseHelper.create(Place, {location, name, category, description, lat, lon});
    })
};




export default PlaceController;