import express from 'express';
import Promise from 'bluebird';

import environment from './config/environment';
import database from './config/database';
import routes from './config/routes';
import {LogHelper} from './helpers';
import settings from './config/settings';

const DEBUG_ENV = 'server';
const app = express();

const promise = Promise.resolve()
  .then(() => {
    LogHelper.info('Node Environment: ' + process.env.NODE_ENV, DEBUG_ENV);
    LogHelper.info('Setting up environment...', DEBUG_ENV);
    return environment(app);
  })
  .then(() => {
    LogHelper.info('Settings up database...', DEBUG_ENV);
    return database(app);
  })
  .then(() => {
    LogHelper.info('Setting up routes...', DEBUG_ENV);
    return routes(app);
  })
  .then(() => {
    app.listen(settings.PORT);
    LogHelper.info('Server Started at port ' + settings.PORT, DEBUG_ENV);
  })
  .catch((err) => {
    LogHelper.error(err.stack, DEBUG_ENV);
    process.kill(process.pid, 'SIGKILL');
  });

export default promise;
