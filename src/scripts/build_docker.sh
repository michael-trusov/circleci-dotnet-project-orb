#!/bin/bash
#shellcheck disable=all

echo "CONATINER_REGISTRY_URL: ${CONTAINER_REGISTRY_URL}"
echo "ACR_URL: ${ACR_URL}"
echo "IMAGE_NAME: ${IMAGE_NAME}"
echo "IMAGE_TAG: ${IMAGE_TAG}"
echo "DOCKERFILE: ${DOCKERFILE}"

docker build -f ${DOCKERFILE} -t ${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_CONTEXT}