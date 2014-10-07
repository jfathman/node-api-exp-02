# Dockerfile

FROM ubuntu:14.04

MAINTAINER jfathman

RUN apt-get update           >/install.log
RUN apt-get -y upgrade      >>/install.log 2>&1
RUN apt-get -y install wget >>/install.log 2>&1

ENV NODE_VERSION 0.10.32

RUN cd /opt \
  && wget -q http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz \
  && tar -xzf node-v${NODE_VERSION}-linux-x64.tar.gz \
  && rm -f node-v${NODE_VERSION}-linux-x64.tar.gz \
  && mv node-v${NODE_VERSION}-linux-x64 node \
  && cd /usr/local/bin \
  && ln -s /opt/node/bin/* .

COPY . /opt/node-api-exp-02/

WORKDIR /opt/node-api-exp-02/

RUN npm install >>/install.log

RUN ln -s /opt/node-api-exp-02/node_modules/.bin/* /usr/local/bin/.

CMD ["node", "app.js"]
