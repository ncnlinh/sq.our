import {
  UserController,
  FlightSearchController,
  FlightController,
  LocationSearchController,
  PlaceController,
  MiscController
} from 'controllers';

export default (app) => {
  app.post('/api/login', UserController.request.createUser);
  app.post('/api/flight/users', FlightController.request.findUsersForFlight);
  app.post('/api/flightsearch', FlightSearchController.request.search);
  app.post('/api/flight/queryAndCreate', FlightController.request.queryAndCreate);
  app.post('/api/flight/addUser', FlightController.request.addUser);
  app.post('/api/locationsearch', LocationSearchController.request.search);
  app.post('/api/place/queryAndCreate', PlaceController.request.queryAndCreate);
  app.post('/api/user/likePlace', UserController.request.addLikedPlace);
  app.post('/api/user/passPlace', UserController.request.addPassedPlace);
  app.post('/api/user/flights', FlightController.request.findFlightsForUser);
  app.post('/api/user/likedPlaces', UserController.request.getLikedPlaces);
  app.post('/api/user/passedPlaces', UserController.request.getPassedPlaces);
  app.post('/api/cities', MiscController.request.getCities);
};
