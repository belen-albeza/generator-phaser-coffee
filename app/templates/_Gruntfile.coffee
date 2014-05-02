'use strict'

path = require 'path'

mountFolder = (connect, dir) ->
  connect.static path.resolve dir

module.exports = (grunt) ->
  grunt.loadNpmTasks task for task in [
    'grunt-coffeelint',
    'grunt-contrib-clean',
    'grunt-contrib-coffee',
    'grunt-contrib-concat',
    'grunt-contrib-connect',
    'grunt-contrib-copy',
    'grunt-contrib-uglify',
    'grunt-contrib-watch',
    'grunt-usemin'
  ]

  grunt.initConfig
    clean:
      app: ['dist', '.tmp']

    coffee:
      app:
        files: [
          expand: true,
          cwd: 'app/coffee'
          src: ['**/*.coffee']
          dest: '.tmp/js'
          ext: '.js'
        ]

    coffeelint:
      all: ['Gruntfile.coffee', 'app/coffee/**/*.coffee']
      options:
        no_throwing_strings:
          level: 'ignore'
        indentation:
          level: 'ignore'

    connect:
      dev:
        options:
          port: 9000
          middleware: (connect) ->
            (mountFolder connect, x) for x in ['app', '.tmp']
          open: 'http://0.0.0.0:<%%= connect.dev.options.port %>'

    copy:
      dist:
        files: [{
          expand: true
          cwd: 'app'
          src: ['**/*.html', 'assets/**/*']
          dest: 'dist'
        }]

    useminPrepare:
      html: 'app/index.html'
      options:
        dest: 'dist'
        flow:
          steps:
            js: ['concat', 'uglifyjs']
          post: {}

    usemin:
      html: 'dist/index.html'

    watch:
      coffeeApp:
        files: ['app/coffee/**/*.coffee']
        tasks: ['coffee:app']

    grunt.registerTask 'build', ['clean', 'coffeelint', 'coffee']
    grunt.registerTask 'release', ['build', 'useminPrepare', 'concat', 'uglify',
      'copy:dist', 'usemin']
    grunt.registerTask 'run', ['build', 'connect:dev', 'watch']
