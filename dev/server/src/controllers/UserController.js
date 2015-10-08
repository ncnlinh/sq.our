import Promise from 'bluebird';

import {MongooseHelper, ResponseHelper} from '../helpers';
import {User} from '../models';

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

UserController.promise.createUser = (req, res) => {
  const {facebookId} = req.body;
  return Promise.resolve(User.findOne({facebookId}).exec())
    .then(MongooseHelper.checkNil)
    .then(() => {
      return MongooseHelper.create(User, {facebookId});
    });
};

export default UserController;