// test-api.js

'use strict';

var should  = require('chai').should();
var request = require('supertest');

// suppress jshint: 'should' is defined but never used
/* exported should */

var host = 'localhost';
var port = '8085';

var apiVersion   = 'v1';
var testUsername = 'jmf';
var testPassword = '1234';

var testInvalidUsername = 'xxx';
var testInvalidPassword = '9999';

process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

describe('Test API REST API', function() {
  it('Create base URI', function(done) {
    var apiUriBase = 'http://' + host + ':' + port + '/api/' + apiVersion;
    request = request(apiUriBase);
    console.log('      ' + apiUriBase);
    done();
  });

  // valid

  it('GET /abc/123 expect 200 OK', function(done) {
    request.get('/abc/123').auth(testUsername, testPassword)
      .expect(200, done);
  });

  it('GET /abc/123, invalid auth user, expect 401 Unauthorized', function(done) {
    request.get('/abc/123').auth(testInvalidUsername, testPassword)
      .expect(401, done);
  });

  it('GET /abc/123, invalid auth password, expect 401 Unauthorized', function(done) {
    request.get('/abc/123').auth(testUsername, testInvalidPassword)
      .expect(401, done);
  });

  /*
  // invalid URI

  it('GET /metadata/abc, invalid URI, expect 400 Bad Request', function(done) {
    request.get('/metadata/invalid').auth(testUsername, testPassword)
      .expect(400, done);
  });

  it('POST /file/new, expect 200 OK', function(done) {
    request.post('/file/1234').auth(testUsername, testPassword)
      .set('Content-Type', 'application/json')
      .send('{ "action": "save" }')
      .expect(200, done);
  });
  */
});
