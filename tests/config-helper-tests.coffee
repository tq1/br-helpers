require('rootpath')()
_ = require('lodash')
chai = require('chai')
expect = chai.expect
assert = chai.assert
sinon = require('sinon')

helpers = require('../lib/helpers')



describe 'Config Helper', () ->

  describe 'Parse Boolean', () ->

    it 'it should return true if string is "True"', (done) ->

      string = 'True'
      assert.isTrue = helpers.config_helper.parseBoolean string
      done()

    it 'it should return false if string is "False"', (done) ->

      boolean = 'False'
      assert.isFalse = helpers.config_helper.parseBoolean boolean
      done()

  describe 'Get Config Value', () ->

    it 'it should return the environment value ', (done) ->

      process.env['Test-1'] = 'test1-env'

      env_value = helpers.config_helper.getConfigValue ['Test-1'], ''
      assert.equal(env_value, 'test1-env')
      done()

    it 'it should return the default value if no env value was set ', (done) ->

      env_value = helpers.config_helper.getConfigValue ['Test-2'], 'test2-env'
      assert.equal(env_value, 'test2-env')
      done()

  describe 'Output Config Value', () ->

    result = null
    before (done) ->
      result = 
        config_1: 'config 1'
        config_2: 
          config_2_1: 'config 2.1'
          config_2_2: 'config 2.2'

      done()


    it 'it should reveal the value to an existent key', (done) ->
      helpers.config_helper.outputConfigValue result, 'config_1', true

      done()

    it 'it should reveal the value to an existent nested key', (done) ->

      helpers.config_helper.outputConfigValue result, '.config_2.config_2_1', true

      done()

    it 'it should reveal the value to a non existent key', (done) ->

      helpers.config_helper.outputConfigValue result, 'config_3', true

      done()

    it 'it should not reveal the value to an existent key', (done) ->

      helpers.config_helper.outputConfigValue result, 'config_1', false


      done()