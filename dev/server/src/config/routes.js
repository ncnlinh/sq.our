import {
  UserController,
  FlightSearchController,
  FlightController
} from 'controllers';

export default (app) => {
  app.post('/api/login', UserController.request.createUser);
  app.post('/api/flightsearch', FlightSearchController.request.search);
  app.post('/api/flight/', FlightController.request.getAll);
  app.post('/api/flight/get', FlightController.request.get);
  app.post('/api/flight/query', FlightController.request.query);
  app.post('/api/flight/queryAndCreate', FlightController.request.queryAndCreate);
  app.post('/api/flight/addUser', FlightController.request.addUser);
};
