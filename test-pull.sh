#!/bin/bash

FULL_IMAGE="$HOST/$IMAGE:$TAG"

echo "Starting image pull test"
echo "Pulling image: $FUll_IMAGE"

if ! command -v podman > /dev/null; then
  echo "Podman not found, exiting"
  exit 1
fi

if podman image exists $FULL_IMAGE; then
  echo "Removing existing image"
  podman rmi $FULL_IMAGE > /dev/null 2>&1
fi

echo "Logging into registry"
podman login -u $REGISTRY_USERNAME -p $REGISTRY_PASSWORD $HOST

if podman pull $FULL_IMAGE; then
  echo "Image pull successful"
  if podman image exists "$FULL_IMAGE"; then
      IMAGE_SIZE=$(podman image inspect "$FULL_IMAGE" --format='{{.Size}}')
      echo "Image size: $(echo $IMAGE_SIZE | numfmt --to=iec-i --suffix=B)"
      exit 0
  else
      echo "ERROR: Image verification failed"
      exit 1
  fi
else
  echo "Image pull failed"
  exit 1
fi
