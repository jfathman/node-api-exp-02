# Dockerfile

FROM ubuntu:14.04

MAINTAINER jfathman

RUN apt-get update           >/install.log
RUN apt-get -y upgrade      >>/install.log 2>&1
RUN apt-get -y install git  >>/install.log 2>&1
RUN apt-get -y install wget >>/install.log 2>&1

RUN \
  cd /opt && \
  wget -q http://nodejs.org/dist/v0.10.32/node-v0.10.32-linux-x64.tar.gz && \
  tar -xzf node-v0.10.32-linux-x64.tar.gz && \
  mv node-v0.10.32-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.32-linux-x64.tar.gz

WORKDIR /src

RUN git clone https://github.com/jfathman/node-api-exp-02.git

WORKDIR /src/node-api-exp-02

RUN npm install >>/install.log

RUN ln -s /src/node-api-exp-02/node_modules/.bin/* /usr/local/bin/.

CMD ["node", "app.js"]
