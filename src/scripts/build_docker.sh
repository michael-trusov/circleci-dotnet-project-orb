#!/bin/bash
#shellcheck disable=all

docker build -f ${DOCKERFILE} -t ${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_CONTEXT}