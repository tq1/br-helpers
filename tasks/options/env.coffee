grunt = require('grunt')

devEnvironment =

  TEST_ENV: "test"

testEnvironment = grunt.util._.extend grunt.util._.clone(devEnvironment),
  NODE_ENV: 'test'

travisEnvironment = grunt.util._.extend grunt.util._.clone(devEnvironment),
  NODE_ENV: 'test'

module.exports =
  dev: devEnvironment
  travis: travisEnvironment
  test: testEnvironment
