module.exports = (grunt) ->

  grunt.registerTask 'test', [
    'env:test'
    'coffeelint'
    'mochaTest'
  ]

  grunt.registerTask 'travis', [
    'env:travis'
    'coffeelint'
    'mochaTest'
  ]

  grunt.registerTask 'default', [
    'coffeelint'
    'concurrent'
  ]