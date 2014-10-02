# Dockerfile

FROM ubuntu:14.04

MAINTAINER jfathman

RUN apt-get -qq update
RUN apt-get -qq upgrade
RUN apt-get -qq install wget
RUN apt-get -qq install git

RUN \
  cd /opt && \
  wget http://nodejs.org/dist/v0.10.32/node-v0.10.32-linux-x64.tar.gz && \
  tar -xzf node-v0.10.32-linux-x64.tar.gz && \
  mv node-v0.10.32-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.32-linux-x64.tar.gz

WORKDIR /src

RUN git clone https://github.com/jfathman/node-api-exp-02.git

WORKDIR /src/node-api-exp-02

RUN npm install

CMD ["node", "app.js"]
