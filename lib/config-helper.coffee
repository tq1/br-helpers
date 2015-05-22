module.exports = (colors) ->

  colors.setTheme
    start: 'underline'
    end: 'grey',
    success: 'green',
    warn: 'yellow',
    error: 'red',
    info: 'white',
    verbose: 'cyan'


  parseBoolean: (value) ->
    return String(value).toLowerCase() is "true"


  getConfigValue: (values = [], defaultValue = null) ->
    result = defaultValue
    for value in values
      return process.env[value] if process.env[value]?
    return result


  outputConfigValue: (config, key, revealValue = false) ->

    Object.byString = (o, s) ->
      s = s.replace(/\[(\w+)\]/g, ".$1") # convert indexes to properties
      s = s.replace(/^\./, "") # strip a leading dot
      a = s.split(".")
      while a.length
        n = a.shift()
        if n of o
          o = o[n]
        else
          return
      return o

    console.info "#{key}: " + if not Object.byString(config, key)? then colors.error("not set") else colors.success(if revealValue then Object.byString(config, key) else "*****")
