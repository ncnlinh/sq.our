import LogHelper from './log';

import Constants from '../config/constants';

export default {
  error: (res, err, debugEnv) => {
    LogHelper.error(err.stack, debugEnv);
    res.status(err.statusCode || Constants.STATUS_BAD_REQUEST);
    if (process.env.NODE_ENV !== 'development') {
      delete err.stack;
    }
    res.send(err);
  },
  success: (res, data) => {
    res.status(Constants.STATUS_SUCCESS);
    res.send(data);
  }
};
