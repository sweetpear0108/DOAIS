#!/bin/sh
set -eu
cd "$(dirname "$0")"
: "${DOCKERHUB_USERNAME:?Set your Docker Hub username}"
image="$DOCKERHUB_USERNAME/llm-multiroute:${IMAGE_TAG:-latest}"
docker build -t "$image" .
docker push "$image"
