import Promise from 'bluebird';
import _ from 'lodash';

import {MongooseHelper, ResponseHelper} from '../helpers';
import {Mastercard} from './ApiHelper/';

const DEBUG_ENV = 'PaymentController';

const PaymentController = {
  request: {},
  promise: {}
};

PaymentController.request.transfer = (req, res) => {
  return Mastercard.services.transfer(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};

PaymentController.request.cardMapCreate = (req, res) => {

  return Mastercard.services.cardMapCreate(req)
    .then((user) => {console.log(user); ResponseHelper.success(res, user)})
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
PaymentController.request.cardMapUpdate = (req, res) => {
  return Mastercard.services.cardMapUpdate(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
PaymentController.request.cardMapInquire = (req, res) => {
  return Mastercard.services.cardMapInquire(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
PaymentController.request.checkEligibility = (req, res) => {
  return Mastercard.services.checkEligibility(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
export default PaymentController;