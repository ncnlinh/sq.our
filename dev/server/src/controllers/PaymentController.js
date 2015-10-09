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
  const {sendingAccountNumber, receivingAccountNumber, amount} = req.body
  return Mastercard.services.transfer(sendingAccountNumber, receivingAccountNumber, amount)
    .then((status) => {
      let statusFunding = (status.Transfer.TransactionHistory[0].Transaction[0].Response[0].Code[0] === "00") //FUNDING
      let descFunding = status.Transfer.TransactionHistory[0].Transaction[0].Response[0].Description[0] //FUNDING
      let statusPayment = (status.Transfer.TransactionHistory[0].Transaction[1].Response[0].Code[0] === "00") //PAYMENT
      let descPayment = status.Transfer.TransactionHistory[0].Transaction[1].Response[0].Description[0] //PAYMENT
      let data = {statusFunding, descFunding, statusPayment, descPayment};
      ResponseHelper.success(res, data);
    })
    .catch((error) => {
      let errorMessage
      if (error.Errors.Error[0].Description) {
        errorMessage = error.Errors.Error[0].Description[0];
      } else {
        let details = error.Errors.Error[0].Details[0].Detail;
        for (let i in details) {
          if (details[i].Name[0] === "ResponseDescription"){
            errorMessage= details[i].Value[0];
            break
          }
        }
      }
      ResponseHelper.error(res, errorMessage, DEBUG_ENV)
    });
};

PaymentController.request.cardMapCreate = (req, res) => {
  const {accountNumber, alias} = req.body
      // 5184680430000006
      // 5184680430000014
      // 5184680430000022
      // 5184680430000030
      // 5184680430000261
      // 5184680430000279
  return Mastercard.services.cardMapCreate(accountNumber, alias)
    .then((user) => {console.log(user); ResponseHelper.success(res, user)})
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
PaymentController.request.cardMapUpdate = (req, res) => {
  const {accountNumber, alias} = req.body
  return Mastercard.services.cardMapUpdate(accountNumber, alias)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
PaymentController.request.cardMapInquire = (req, res) => {
  const {alias} = req.body
  return Mastercard.services.cardMapInquire(alias)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
PaymentController.request.checkEligibility = (req, res) => {
  const {sendingAccountNumber, receivingAccountNumber} = req.body
  return Mastercard.services.checkEligibility(sendingAccountNumber, receivingAccountNumber)
    .then((status) => {
      ResponseHelper.success(res, status.PanEligibility.SendingEligibility[0].Eligible[0])
    })
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
};
export default PaymentController;