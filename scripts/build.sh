#!/bin/bash
set -eu
IFS=$'\n\t'

if test -f cdp-workflows/scripts/build.manifest; then
    . cdp-workflows/scripts/build.manifest
fi

echo "Building docker image and tagging as $IMAGE_NAME:latest and $IMAGE_NAME:$BUILD_VERSION"

docker build \
          --no-cache \
          --tag "$IMAGE_NAME":latest \
          --tag "$IMAGE_NAME:$BUILD_VERSION" \
          --label defra.cdp.git.repo.url="$BUILD_GIT_REPOSITORY_URL" \
          --label defra.cdp.service.name="$IMAGE_NAME" .
