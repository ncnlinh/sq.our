import Promise from 'bluebird';
import _ from 'lodash';
import {MongooseHelper, ResponseHelper} from '../helpers';
import {User, Flight} from '../models';

const DEBUG_ENV = 'FlightController';

const FlightController = {
  request: {},
  promise: {}
};


FlightController.request.get = (req, res) => {
  FlightController.promise.get(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

FlightController.request.getAll = (req, res) => {
  FlightController.promise.getAll(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

FlightController.request.query = (req, res) => {
  FlightController.promise.query(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

FlightController.request.queryAndCreate = (req, res) => {
  FlightController.promise.queryAndCreate(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

FlightController.request.addUser = (req, res) => {
  FlightController.promise.addUser(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
  
 
FlightController.promise.get = (req, res) => {
  const {_id} = req.body;
  return Promise.resolve(Flight.findOne({_id}).populate('users').exec((err, users) => {console.log (users)}))
    .then(MongooseHelper.checkExists)

};

FlightController.promise.getAll = (req, res) => {
  const {_id} = req.body;
  return Promise.resolve(Flight.find().exec())
  //.populate('users').exec((err, users) => {console.log (users)})
    .then(MongooseHelper.checkExists)
};

FlightController.promise.query = (req, res) => {
  const {flightNumbers, startLocation, endLocation, startDate} = req.body;
  return Promise.resolve(Flight.findOne({flightNumbers, startLocation, endLocation, startDate}).populate('users').exec((err, users) => {console.log (users)}))
    .then(MongooseHelper.checkExists)
};

FlightController.promise.queryAndCreate = (req, res) => {
  const {flightNumbers, startLocation, endLocation, startDate} = req.body;
  return Promise.resolve(Flight.findOne({flightNumbers, startLocation, endLocation, startDate})
    .populate('users').exec((err, users) => {console.log (users)}))
    .then(MongooseHelper.checkExists)
    .catch(() => {
      return MongooseHelper.create(Flight, {flightNumbers, startLocation, endLocation, startDate, users:[]});
    })
};

FlightController.promise.addUser = (req, res) => {
  const {_id} = req.body;
  const reqUser = req.body.user;
  
  return MongooseHelper.findOne(Flight,{_id: _id})
    .then((flight) => {
      let flightItem = _.extend(flight.toObject(), {places: []});
      return MongooseHelper.findOne(User, {facebookId: reqUser.facebookId})
      .then(MongooseHelper.checkExists)
      .then((user)=> {
        let userItem = _.extend(user.toObject(),{purpose: reqUser.purpose});
        if (_.result(_.find(flight.users, (chr) => {
           if (chr) { 
            return chr.facebookId === user.facebookId; 
           }
          }),'_id') === undefined) {
          return MongooseHelper.findOneAndUpdate(User, {facebookId: reqUser.facebookId},
            {$push: {flights: flightItem}}, {new: true}, {populate: 'flights'})
          .then(() => {
            return MongooseHelper.findOneAndUpdate(Flight, {_id: _id}, 
              {$push: {users: userItem}}, {new: true}, {populate: 'users'});
          });
        }
        return Promise.resolve(flight);
      })
    })
    .then(MongooseHelper.checkExists)
  }



export default FlightController;