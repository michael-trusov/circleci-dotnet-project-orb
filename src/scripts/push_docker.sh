#!/bin/bash
#shellcheck disable=all

docker login -u $ACR_USERNAME -p $ACR_PASSWORD $ACR_URL
docker push ${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG}