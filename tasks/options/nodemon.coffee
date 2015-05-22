env = require('./env')

module.exports =
  app:
    script: 'index.js'
    options:
      cwd: '.'
      nodeArgs: ['--debug']
      ext: 'js,coffee'
      env: env.dev