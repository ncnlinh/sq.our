import Promise from 'bluebird';
import _ from 'lodash';

import {MongooseHelper, ResponseHelper} from '../helpers';
import {Mastercard} from './ApiHelper/';
import {User, PaymentRequest} from '../models';
import {ClientError} from '../helpers/errors';
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
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
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

PaymentController.request.ask = (req, res) => {
  PaymentController.promise.ask(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
}

PaymentController.promise.ask = (req, res) => {
  const {requestUser, receivingAccountNumber, receivedUser, amount, reason} = req.body;
  return MongooseHelper.create(PaymentRequest, {requestUser, receivingAccountNumber, receivedUser, amount, reason, status: "Unpaid"})
}

PaymentController.request.view = (req, res) => {
  PaymentController.promise.view(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
}

PaymentController.promise.view = (req, res) => {
  const {facebookId} = req.body;
  return MongooseHelper.find(PaymentRequest, {receivedUser: facebookId})
    .then((paymentRequests) => {
      let rs = paymentRequests;
      return MongooseHelper.find(User)
      .then((allUsers) => {
        let us = allUsers;
        rs = rs.map((r) => {
          let r2 = r.toObject();
          let i =_.findIndex(us,(chr) => {return chr.facebookId.toString() === r.requestUser});
          r2.requestUser = us[i]
          return r2;
        });
        return Promise.resolve(rs);
      })
    });
}

PaymentController.request.pay = (req, res) => {
  PaymentController.promise.pay(req)
    .then((user) => ResponseHelper.success(res, user))
    .catch((error) => ResponseHelper.error(res, error, DEBUG_ENV));
}

PaymentController.promise.pay = (req, res) => {
  const {_id, sendingAccountNumber} = req.body;
  return MongooseHelper.findOne(PaymentRequest, {_id: _id})
  .then((request)=> {
    return Mastercard.services.transfer(sendingAccountNumber, request.receivingAccountNumber, request.amount)
    .then((status)=>{
      return MongooseHelper.findOneAndUpdate(PaymentRequest, {_id: _id}, {sendingAccountNumber: sendingAccountNumber, status: "Paid"}, {new: true});
    })
  })
}
export default PaymentController;