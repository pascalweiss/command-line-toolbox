#!/usr/bin/env bash

set -e

# Directories and image details
APP_DIR=$(dirname "${0}")/..
HOMELAB_DIR="${APP_DIR}"/../..
APP_NAME="command-line-toolbox"
DOCKER_IMAGE="${APP_NAME}-docker"
DOCKER_TAG="0.1.0"
USER_NAME="user"

# Load environment variables (e.g., DOCKER_REPO, GITLAB_USER, GITLAB_TOKEN)
source "${HOMELAB_DIR}"/.env

# Log in to the Docker repository
docker login "${DOCKER_REPO}" -u "${GITLAB_USER}" -p "${GITLAB_TOKEN}"

# Ensure Docker Buildx is available
if ! docker buildx version >/dev/null 2>&1; then
    echo "Docker Buildx is not available. Please update Docker to a version that supports Buildx." >&2
    exit 1
fi

# Create and use a multi-arch builder if it does not exist
BUILDER_NAME="multiarch-builder"
if ! docker buildx ls | grep -q "$BUILDER_NAME"; then
    echo "Creating multi-architecture builder named '$BUILDER_NAME'..."
    docker buildx create --name "$BUILDER_NAME" --use
    docker buildx inspect --bootstrap
fi

# Build and push the multi-architecture image for:
#  - linux/386      (Linux on Intel 32-bit)
#  - linux/amd64    (Linux on AMD/Intel 64-bit)
#  - darwin/amd64   (MacOS on Intel)
docker buildx build \
  --platform linux/arm64,linux/amd64 \
  --build-arg USER_NAME="${USER_NAME}" \
  -t "${DOCKER_REPO}/${DOCKER_IMAGE}:${DOCKER_TAG}" \
  "${APP_DIR}" \
  --push