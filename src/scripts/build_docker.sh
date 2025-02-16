#!/bin/bash
#shellcheck disable=all

docker build -f Dockerfile -t "${CONTAINER_REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}" .