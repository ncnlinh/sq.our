import Promise from 'bluebird';
import _ from 'lodash';

import {MongooseHelper, ResponseHelper} from '../helpers';
import {User, Flight, Place} from '../models';

const DEBUG_ENV = 'UserController';

const UserController = {
  request: {},
  promise: {}
};

UserController.request.createUser = (req, res) => {
  UserController.promise.createUser(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.request.getAll = (req, res) => {
  UserController.promise.getAll(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.request.addLikedPlace = (req, res) => {
  UserController.promise.addLikedPlace(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.request.addPassedPlace = (req, res) => {
  UserController.promise.addPassedPlace(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.request.getFlights = (req, res) => {
  UserController.promise.getFlights(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.request.getLikedPlaces = (req, res) => {
  UserController.promise.getLikedPlaces(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.request.getPassedPlaces = (req, res) => {
  UserController.promise.getPassedPlaces(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

UserController.promise.createUser = (req, res) => {
  const {facebookId, name} = req.body;
  return Promise.resolve(User.findOne({facebookId}).exec())
    .then(MongooseHelper.checkExists)
    .catch(() => {
      return MongooseHelper.create(User, {facebookId, name});
    })
};

UserController.promise.getAll = (req, res) => {
  return MongooseHelper.find(User);
}

UserController.promise.addLikedPlace = (req, res) => {
  const {facebookId, flightId, placeId} = req.body;
  return MongooseHelper.findOneAndUpdate(User, {facebookId: facebookId, 'flights._id': flightId}, {
    $addToSet: {
      'flights.$.likedPlaces': placeId
    }
  });
};

UserController.promise.addPassedPlace = (req, res) => {
  const {facebookId, flightId, placeId} = req.body;
  return MongooseHelper.findOne(User, {facebookId: facebookId})
    .then((user) => {
      let flights = user.toObject().flights;
      console.log(flights);
      if (_.findIndex(flights, (chr) => {
       if (chr) { return chr._id.toString() === flightId; }
      }) !== -1) {
        let index = _.findIndex(flights, (chr) => {
         if (chr) { return chr._id.toString() === flightId; }
        });
        return MongooseHelper.findOne(Place, {_id: placeId})
          .then((place) => {
            if (_.findIndex(flights, (chr) => {
             if (chr) { return chr._id.toString() === placeId; }
            }) !== -1) {
              flights[index].passedPlaces.push({_id: placeId});
            }
            
            return MongooseHelper.findOneAndUpdate(User, {facebookId}, {flights}, {new: true}, {populate: 'flights.passedPlaces'})
          });
      }
    });
};

UserController.promise.getFlights = (req, res) => {
  const {facebookId} = req.body;
  let resFlights = [];
  return MongooseHelper.findOne(User, {facebookId: facebookId})
  .then((user) => {
    if (!user) {
      return [];
    }
    let flights = user.toObject().flights;
    return MongooseHelper.find(Flight)
      .then((allFlights) => {
        flights = flights.map((flight) => {
          return allFlights[_.findIndex(allFlights, {_id: flight._id})];
        })
        return Promise.resolve(flights);
      })
  })
};


UserController.promise.getLikedPlaces = (req, res) => {
  const {facebookId, flightId} = req.body;
  let resFlights = [];
  return MongooseHelper.findOne(User, {facebookId: facebookId})
  .then((user) => {
    let flights = user.toObject().flights;
    if (_.findIndex(flights, (chr) => {
       if (chr) { return chr._id.toString() === flightId; }
      }) !== -1) {
        let index = _.findIndex(flights, (chr) => {
         if (chr) { return chr._id.toString() === flightId; }
        });
        let flight=flights[index];
        console.log(flight);
        let places=flight.likedPlaces;
        return MongooseHelper.find(Place)
          .then((allPlaces) => {
            places = places.map((place) => {
              return allPlaces[_.findIndex(allPlaces, {_id: place._id})];
            })
            return Promise.resolve(places);
          })
      }
  })
};


UserController.promise.getPassedPlaces = (req, res) => {
  const {facebookId, flightId} = req.body;
  let resFlights = [];
  return MongooseHelper.findOne(User, {facebookId: facebookId})
  .then((user) => {
    let flights = user.toObject().flights;
    if (_.findIndex(flights, (chr) => {
       if (chr) { return chr._id.toString() === flightId; }
      }) !== -1) {
        let index = _.findIndex(flights, (chr) => {
         if (chr) { return chr._id.toString() === flightId; }
        });
        let flight=flights[index];
        console.log(flight);
        let places=flight.passedPlaces;
        return MongooseHelper.find(Place)
          .then((allPlaces) => {
            places = places.map((place) => {
              return allPlaces[_.findIndex(allPlaces, {_id: place._id})];
            })
            return Promise.resolve(places);
          })
      }
  })
};

export default UserController;