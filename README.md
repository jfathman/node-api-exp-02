## node-api-exp-02 ##

  Experimental source used for Docker CI exploration.

  * REST API
  * Express 4
  * Microservices architecture
  * Jenkins CI

### Docker ###

Build Docker image:

    $ sudo docker build -t node-api-exp-02:1.0.0 .

Run Node app.js in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 node-api-exp-02:1.0.0

Run Grunt test in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 node-api-exp-02:1.0.0 ./node_modules/.bin/grunt

Run bash in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 node-api-exp-02:1.0.0 /bin/bash

### Test ###

    $ curl --user jmf:1234 http://<ip>:8085/api/v1/abc/123 -i -X GET

### License ###

  MIT
