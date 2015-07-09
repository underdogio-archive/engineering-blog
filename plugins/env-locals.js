var Settings = require('shallow-settings');
var _ = require('underscore');

module.exports = function (env, callback) {
  var node_env = process.env.NODE_ENV || 'development';
  var settings = new Settings(env.config['env-locals']);
  // DEV: Do not override `env.locals`, we will lose `typogr`, `_`, `moment`, and etc
  env.locals = _.extend(env.locals, settings.getSettings({env: node_env}));

  callback();
};
