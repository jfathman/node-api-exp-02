## node-api-exp-02 ##

  Experimental source used for Docker CI exploration.

  * REST API application
  * Microservices architecture
  * API mock tests using Mocha, Chai, Supertest, Loadtest
  * Node.js
  * Express 4
  * Docker
  * Jenkins CI
  * Artifactory artifact repository
  * Ubuntu Server 14.04 LTS 64-bit

### Docker ###

Build Docker image:

    $ sudo docker build -t node-api-exp-02:1.0.0 .

Remove untagged images after Docker reuses repo:tag for new build:

    $ sudo docker rmi $(sudo docker images --filter "dangling=true" -q)

Retrieve build artifacts from Docker container:

    $ sudo docker run --rm -v ${PWD}:/mnt node-api-exp-02:1.0.0 /bin/bash -c 'cp artifacts/* /mnt/.'

Run mock tests including load test in Docker container:

    $ sudo docker run --rm node-api-exp-02:1.0.0 grunt test

Run Node app.js in production mode in Docker container:

    $ sudo docker run --name api-02 --rm -p 8085:8085 -e NODE_ENV=prod node-api-exp-02:1.0.0

Run bash in Docker container:

    $ sudo docker run --name api-02 --rm -i -t -p 8085:8085 node-api-exp-02:1.0.0 /bin/bash

### Permit Jenkins to run Docker ###

    $ sudo usermod -a -G docker jenkins
    $ sudo service jenkins restart

### Jenkins Execute Shell Command ###

    docker build -t node-api-exp-02:1.0.0 .
    docker rmi $(docker images --filter "dangling=true" -q)
    docker run --rm node-api-exp-02:1.0.0 grunt --no-color test
    mkdir -p artifacts
    docker run --rm -v ${PWD}/artifacts:/mnt node-api-exp-02:1.0.0 /bin/bash -c 'cp artifacts/* /mnt/.'
    # cp ./artifacts/* /some/artifact/repository/path/.

### Manual Curl Test ###

    $ curl --user jmf:1234 http://<ip>:8085/api/v1/abc/123 -i -X GET

### License ###

  MIT
