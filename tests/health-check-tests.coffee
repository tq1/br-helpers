chai = require('chai')
sinon = require("sinon")
sinonChai = require("sinon-chai")
assert = chai.assert
chai.use sinonChai
http = require('http')


helpers = require('../lib/helpers')

express = require('express')

server = null
port = 3003

describe 'Health Check', () ->

  before (done) ->
    app = express()
    helpers.health_check app
    server = app.listen port, () ->
      done()

  it 'Return status 200', (done) ->

    options =
      'host': 'localhost'
      'port': port
      'path': '/health-check'
      'method': 'GET'
      'headers':
        'Content-Type': 'application/json'

    req = http.request options, (res) ->
      assert.equal res.statusCode, 200
      done()
    req.end()
