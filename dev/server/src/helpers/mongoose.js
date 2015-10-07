import Constants from '../config/constants';
import Promise from 'bluebird';
import mongoose from 'mongoose';

import {ClientError} from 'helpers';

export default {
  isObjectId: (str) => {
    return mongoose.Types.ObjectId.isValid(str);
  },

  checkExists: (obj) => {
    return new Promise((resolve, reject) => {
      if (obj) {
        resolve(obj);
      } else {
        reject(new ClientError(Constants.ERROR_DOES_NOT_EXIST));
      }
    });
  },

  checkNil: (obj) => {
    return new Promise((resolve, reject) => {
      if (!obj) {
        resolve();
      } else {
        reject(new ClientError(Constants.ERROR_DID_EXIST));
      }
    });
  },

  checkEmpty: (count) => {
    return new Promise((resolve, reject) => {
      if (count === 0) {
        resolve();
      } else {
        reject();
      }
    });
  },

  checkNotEmpty: (count) => {
    return new Promise((resolve, reject) => {
      if (count > 0) {
        resolve();
      } else {
        reject(new ClientError(Constants.ERROR_DOES_NOT_EXIST));
      }
    });
  },

  toObject: (obj) => {
    return new Promise((resolve, reject) => {
      if (obj.toObject) {
        resolve(obj.toObject());
      } else {
        reject(new ClientError(Constants.ERROR_NOT_MONGOOSE_OBJECT));
      }
    });
  },

  create: (Schema, data) => {
    return new Promise((resolve, reject) => {
      Schema.create(data, (err, result) => {
        if (err) {
          reject(err);
        } else {
          resolve(result);
        }
      });
    });
  },

  findOne: (Schema, query, options = {}) => {
    const request = Schema.findOne(query);
    if (options.populate) {
      request.populate(options.populate);
    }
    if (options.select) {
      request.select(options.select);
    }
    if (options.lean) {
      request.lean();
    }

    return Promise.resolve(request.exec());
  },

  find: (Schema, query, options = {}) => {
    const request = Schema.find(query);
    if (options.populate) {
      request.populate(options.populate);
    }
    if (options.select) {
      request.select(options.select);
    }
    if (options.lean) {
      request.lean();
    }

    return Promise.resolve(request.exec());
  },

  findOneAndUpdate: (Schema, query, update, updateOptions = {}, options = {}) => {
    const request = Schema.findOneAndUpdate(query, update, updateOptions);
    if (options.populate) {
      request.populate(options.populate);
    }
    if (options.select) {
      request.select(options.select);
    }
    if (options.lean) {
      request.lean();
    }

    return Promise.resolve(request.exec());
  },

  batchCreate: (Schema, docs) => {
    const versionedDocs = docs.map((doc) => {
      if (!doc.__v) {
        doc.__v = 0;
      }

      return doc;
    });
    return new Promise((resolve, reject) => {
      Schema.collection.insert(versionedDocs, (err, results) => {
        if (err) {
          return reject(err);
        }
        return resolve(results);
      });
    });
  },

  batchUpsert: (Schema, docs) => {
    return new Promise((resolve, reject) => {
      const bulk = Schema.collection.initializeUnorderedBulkOp();
      docs.forEach((doc) => {
        bulk.find(doc.query).upsert.updateOne(doc.data);
      });
      bulk.execute((err, res) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  },

  batchUpdate: (Schema, updateOps, isOrdered = false) => {
    return new Promise((resolve, reject) => {
      if (updateOps.length === 0) {
        return resolve();
      }

      let bulk;
      if (isOrdered) {
        bulk = Schema.collection.initializeOrderedBulkOp();
      } else {
        bulk = Schema.collection.initializeUnorderedBulkOp();
      }

      updateOps.forEach((updateOp) => {
        bulk.find(updateOp.query).updateOne(updateOp.update);
      });
      bulk.execute((err, res) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};
