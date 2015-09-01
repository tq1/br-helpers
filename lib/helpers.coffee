colors = require('colors')

helpers = 
  config_helper: require('./config-helper')(colors)
  health_check: require('./health-check')

module.exports = helpers