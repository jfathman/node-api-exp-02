#! /bin/bash

# jenkins-build.sh

set -e

# Assumes prior export ARTIFACTORY_ACCOUNT is available.

set +x
echo
echo "Get application name and version from package.json."
echo
set -x

APP_NAME=$(cat package.json | jq -r '.name')

APP_VERSION=$(cat package.json | jq -r '.version')

set +x
echo
echo "Build Docker image."
echo
set -x

docker build -t ${APP_NAME}:${APP_VERSION} .

set +x
echo
echo "Remove untagged images after Docker reuses repo:tag for new build."
echo
set -x

UNTAGGED=$(docker images --filter "dangling=true" -q)

if [ ! -z "$UNTAGGED" ]; then
  docker rmi ${UNTAGGED};
fi

set +x
echo
echo "Run mock tests including load test in Docker container."
echo
set -x

docker run --rm ${APP_NAME}:${APP_VERSION} grunt --no-color test

set +x
echo
echo "Retrieve build artifacts from Docker container."
echo
set -x

mkdir -p artifacts

docker run --rm -v ${PWD}/artifacts:/mnt ${APP_NAME}:${APP_VERSION} /bin/bash -c 'cp artifacts/* /mnt/.'

set +x
echo
echo "Tag Docker image for Artifactory, push image to Artifactory, and remove tag."
echo
set -x

docker tag ${APP_NAME}:${APP_VERSION} ${ARTIFACTORY_ACCOUNT}.artifactoryonline.com/${APP_NAME}:${APP_VERSION}

docker push ${ARTIFACTORY_ACCOUNT}.artifactoryonline.com/${APP_NAME}:${APP_VERSION}

docker rmi ${ARTIFACTORY_ACCOUNT}.artifactoryonline.com/${APP_NAME}:${APP_VERSION}

set +x
echo
echo "Build complete."
echo
