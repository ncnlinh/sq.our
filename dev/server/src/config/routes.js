import {
  UserController  
} from 'controllers';

export default (app) => {
  app.post('/user/register', UserController.request.createUser);
};
