#! /bin/bash

# jenkins-build.sh

set -e

# Assumes prior export ARTIFACTORY_ACCOUNT is available.

# Get application name and version from package.json.

APP_NAME=$(cat package.json | jq -r '.name')

APP_VERSION=$(cat package.json | jq -r '.version')

# Build Docker image.

docker build -t ${APP_NAME}:${APP_VERSION} .

# Remove untagged images after Docker reuses repo:tag for new build.

UNTAGGED=$(docker images --filter "dangling=true" -q)

if [ ! -z "$UNTAGGED" ]; then
  docker rmi ${UNTAGGED};
fi

# Run mock tests including load test in Docker container.

docker run --rm ${APP_NAME}:${APP_VERSION} grunt --no-color test

# Retrieve build artifacts from Docker container.

mkdir -p artifacts

docker run --rm -v ${PWD}/artifacts:/mnt ${APP_NAME}:${APP_VERSION} /bin/bash -c 'cp artifacts/* /mnt/.'

# Tag Docker image for Artifactory, push image to Artifactory, and remove tag.

docker tag ${APP_NAME}:${APP_VERSION} ${ARTIFACTORY_ACCOUNT}.artifactoryonline.com/${APP_NAME}:${APP_VERSION}

docker push ${ARTIFACTORY_ACCOUNT}.artifactoryonline.com/${APP_NAME}:${APP_VERSION}

docker rmi ${ARTIFACTORY_ACCOUNT}.artifactoryonline.com/${APP_NAME}:${APP_VERSION}

