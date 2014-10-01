FROM ubuntu:14.04

MAINTAINER jfathman

RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install wget -y
RUN apt-get install git -y

# Install Node
RUN   \
  cd /opt && \
  wget http://nodejs.org/dist/v0.10.32/node-v0.10.32-linux-x64.tar.gz && \
  tar -xzf node-v0.10.32-linux-x64.tar.gz && \
  mv node-v0.10.32-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.32-linux-x64.tar.gz

# Set the working directory
WORKDIR   /src

# Clone project
RUN git clone https://github.com/jfathman/node-api-exp-02.git

# Install Node modules
RUN cd ./node-api-exp-02; npm install

# Default command
CMD ["/bin/bash"]
