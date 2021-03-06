import winston from 'winston';
winston.emitErrs = true;

export default new winston.Logger({
  transports: [
    new winston.transports.Console({
      level: 'debug',
      handleExceptions: true,
      humanReadableUnhandledException: true,
      json: false,
      colorize: true,
      timestamp: true
    })
  ],
  exitOnError: false
});
