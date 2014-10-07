## node-api-exp-02 ##

  Experimental source used for Docker CI exploration.

  * REST API application
  * Microservices architecture
  * API mock tests using Mocha, Chai, Supertest, Loadtest
  * Node.js
  * Express 4
  * Docker
  * Jenkins CI

### Docker ###

Build Docker image:

    $ sudo docker build -t node-api-exp-02:1.0.0 .

Run bash in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 node-api-exp-02:1.0.0 /bin/bash

Run mock tests including load test in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 node-api-exp-02:1.0.0 grunt test

Run Node app.js in production mode in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 -e NODE_ENV=prod node-api-exp-02:1.0.0

### Permit Jenkins to run Docker ###

    $ sudo usermod -a -G docker jenkins
    $ sudo service jenkins restart

### Jenkins Execute Shell Command ###

    docker build -t node-api-exp-02:1.0.0 .
    docker run --name api-02 --rm -i -p 8085:8085 node-api-exp-02:1.0.0 grunt test --no-color

### Manual Curl Test ###

    $ curl --user jmf:1234 http://<ip>:8085/api/v1/abc/123 -i -X GET

### License ###

  MIT
