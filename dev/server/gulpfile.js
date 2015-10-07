var gulp = require('gulp');
var _ = require('lodash');
var spawn = require('child_process').spawn;
require('./gulp/task-eslint');

gulp.task('dev', function() {
  var developmentEnv = _.cloneDeep(process.env);
  developmentEnv.NODE_ENV = 'development';
  spawn('nodemon', ['index'], {
    env: developmentEnv,
    stdio: 'inherit'
  });
});

gulp.task('prod', function() {
  var productionEnv = _.cloneDeep(process.env);
  productionEnv.NODE_ENV = 'production';
  spawn('node', ['index'], {
    env: productionEnv,
    stdio: 'inherit'
  });
});

gulp.task('pm2', function() {
  spawn('pm2', ['start', 'processes.json'], {
    stdio: 'inherit'
  });
});
