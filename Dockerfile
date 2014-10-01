FROM dockerfile/ubuntu

MAINTAINER jfathman

# Install Node
RUN   \
  cd /opt && \
  wget http://nodejs.org/dist/v0.10.29/node-v0.10.29-linux-x64.tar.gz && \
  tar -xzf node-v0.10.29-linux-x64.tar.gz && \
  mv node-v0.10.29-linux-x64 node && \
  cd /usr/local/bin && \
  ln -s /opt/node/bin/* . && \
  rm -f /opt/node-v0.10.29-linux-x64.tar.gz

# Set the working directory
WORKDIR   /src

# Default command
CMD ["/bin/bash"]
