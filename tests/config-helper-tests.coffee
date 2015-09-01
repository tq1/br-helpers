chai = require('chai')
sinon = require("sinon")
sinonChai = require("sinon-chai")
assert = chai.assert
chai.use sinonChai


helpers = require('../lib/helpers')
config_helper = helpers.config_helper

describe 'Config Helper', () ->

  describe 'Get Values', () ->

    value = 'value'

    beforeEach () ->
      process.env.KEY = value

    it 'should get environment variable', (done) ->

      assert.equal config_helper.getConfigValue(['KEY']), value
      done()

    it 'should get second environment variable if first is not present', (done) ->

      assert.equal config_helper.getConfigValue(['KEY_NOT_PRESENT', 'KEY']), value
      done()

    it 'should get default value if no environment variable is present', (done) ->

      assert.equal config_helper.getConfigValue(['KEY_NOT_PRESENT'], 'default'), 'default'
      done()

  describe 'Parse Boolean', () ->

    it 'should parse boolean string properly', (done) ->

      assert.equal config_helper.parseBoolean('true'), true
      assert.equal config_helper.parseBoolean('True'), true
      assert.equal config_helper.parseBoolean('false'), false
      assert.equal config_helper.parseBoolean('random string'), false
      done()

  describe 'Output Config Values', () ->

    log_spy = null

    beforeEach () ->

      log_spy =  sinon.spy console, 'info'

    afterEach () ->

      log_spy.restore()
      log_spy = null


    it 'should print value in console.log', (done) ->

      obj =
        key: 'key value'
        nested:
          key: 'nested value'

      config_helper.outputConfigValue obj, "key", true
      config_helper.outputConfigValue obj, "nested.key", true

      assert log_spy.callCount, 2

      spyCall0 = log_spy.getCall(0)
      spyCall1 = log_spy.getCall(1)

      assert.match spyCall0.args[0], /key value/
      assert.match spyCall1.args[0], /nested value/

      done()

    it 'should print \'not set\' console.log if key is not present', (done) ->

      obj = {}

      config_helper.outputConfigValue obj, "key not present", true

      assert log_spy.callCount, 1

      spyCall0 = log_spy.getCall(0)

      assert.match spyCall0.args[0], /not set/

      done()

    it 'should not print value in console.log if it was asked to hide', (done) ->

      obj =
        key: 'key value'

      config_helper.outputConfigValue obj, "key", false

      assert log_spy.callCount, 1

      spyCall0 = log_spy.getCall(0)

      assert.match spyCall0.args[0], /\*\*\*\*\*/

      done()