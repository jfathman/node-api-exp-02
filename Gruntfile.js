// Gruntfile.js
  
'use strict';
  
module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    jshint: {
      file: ['Gruntfile.js', 'app.js', 'test/*.js'],
      options: {
        jshintrc: true
      }
    },
    mochaTest: {
      test: {
        options: {
          reporter: 'spec'
        },
        src: ['test/*.js']
      }
    },
    shell: {
      shrinkwrap: {
        command: 'npm shrinkwrap --dev'
      }
    }
  });

  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-mocha-test');
  grunt.loadNpmTasks('grunt-contrib-jshint');

  grunt.registerTask('shrinkwrap', 'Create npm-shrinkwrap.json file.', ['shell:shrinkwrap']);
  grunt.registerTask('test', 'Run jshint and mochaTest.', ['jshint', 'mochaTest']);
  grunt.registerTask('default', 'Run jshint.', ['jshint']);
};
