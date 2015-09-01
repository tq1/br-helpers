# TQ1-Helpers

## Usage

1. Add `br-tq1-helpers` dependency to your `package.json`

  ```json
  "dependencies": {
    "br-tq1-helpers": "git+https://github.com/tq1/tq1-helpers.git"
  }
  ```
2. Call `helpers = require("br-tq1-helpers")`. The require method returns a object which contains all the helpers.

  ```
  helpers = require("br-tq1-helpers")

  config_helper = helpers.config_helper

  helpers.health_check app

  ```

## Config Helper

  The config helper module have the following methods:
    - parseBoolean(value): This method transform the string value in the respective boolean value.
    - getConfigValue(key, defaultValue): This function get the environment value of the key. If doesn't exist, it returns the default value.
    - outputConfigValue(config, key, revealValue): This function print the key and the value of the config object. The revealValue option is a boolean which can hide the value of the key.

### Example

  - Parse Boolean

  ```
  config_helper.parseBoolean 'True'  # It return true
  config_helper.parseBoolean 'False' # It return false
  ```

  - Get Config Value

  ```
  process.env['Test-1'] = 'test1-env'
  config_helper.getConfigValue 'Test-1', 'test-default' # It return 'test1-env'
  config_helper.getConfigValue 'Test-2', 'test-default' # It return 'test-default'
  ```

  - Output Config Value

  ```
  result = 
        config_1: 'config 1'
        config_2: 
          config_2_1: 'config 2.1'
          config_2_2: 'config 2.2'

  config_helper.outputConfigValue result, 'config_1', true               # It prints 'config_1: config 1'
  config_helper.outputConfigValue result, '.config_2.config_2_1', true   # It prints '.config_2.config_2_1: config 2.1'
  config_helper.outputConfigValue result, 'config_1', false              # It prints 'config_1: *****'
  config_helper.outputConfigValue result, 'config_3', true               # It prints 'config_3: not set'
  ```

## API Health Check endpoint

  This enpoint is to use as a health check. It only returns status 200 on request to '/health-check' path. Use this before any middleware validation. 

### Example

  ```
    express = require('express')
    helpers = require("br-tq1-helpers")

    app = express()
    helpers.health_check app
    ...
  ```

## Test

```
$ npm install
$ node run test
```