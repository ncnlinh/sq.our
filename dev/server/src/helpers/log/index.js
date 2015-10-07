import split from 'split';

let env = 'development';
if (process.env.NODE_ENV !== 'development') {
  env = 'production';
}
const logger = require('./' + env);

const LogHelper = {
  debug: function(str, debugEnv) {
    this.log(str, debugEnv, 'debug');
  },
  info: function(str, debugEnv) {
    this.log(str, debugEnv, 'info');
  },
  warn: function(str, debugEnv) {
    this.log(str, debugEnv, 'warn');
  },
  error: function(str, debugEnv) {
    this.log(str, debugEnv, 'error');
  },
  stream: split().on('data', (line) => {
    LogHelper.info(line, 'http');
  }),
  log: function(str, debugEnv = 'misc', level) {
    logger.log(level, `${debugEnv}: ${str}`);
  }
};

export default LogHelper;
