#!/usr/bin/env bash

# Exit immediately if a command exits with non-zero status
set -e

# this script builds the docker image using podman and pushes it to registry

DIR=$(dirname "$0")/..
cd "$DIR" || exit 1


if [ -f ".env" ]; then
    source .env
fi

# Set image name and tag
LOCAL_IMAGE_NAME="localhost/$IMAGE_NAME:$TAG"
REMOTE_IMAGE_NAME="$DOCKER_REGISTRY/$IMAGE_NAME:$TAG"

echo "Building $LOCAL_IMAGE_NAME with Podman..."

# Build the image with fully qualified image name to avoid short-name resolution error
podman build --format docker -t "$LOCAL_IMAGE_NAME" -f Dockerfile .

echo "Build completed successfully!"

# Tag the image for the registry
echo "Tagging image as $REMOTE_IMAGE_NAME..."
podman tag "$LOCAL_IMAGE_NAME" "$REMOTE_IMAGE_NAME"

# Login to registry using saved credentials
echo "Logging into registry $DOCKER_REGISTRY..."
echo "$NEXUS_PASSWORD" | podman login -u "$NEXUS_USERNAME" --password-stdin "$DOCKER_REGISTRY"

# Push the image
echo "Pushing image to $REMOTE_IMAGE_NAME..."
podman push "$REMOTE_IMAGE_NAME"
echo "Image successfully pushed to $REMOTE_IMAGE_NAME"
