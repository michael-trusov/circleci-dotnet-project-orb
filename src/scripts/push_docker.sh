#!/bin/bash
#shellcheck disable=all

docker login -u $ACR_USERNAME -p $ACR_PASSWORD $ACR_URL

echo "ACR_URL=$ACR_URL"
echo "IMAGE_NAME=$IMAGE_NAME"
echo "IMAGE_TAG=$IMAGE_TAG"

docker push $ACR_URL/$IMAGE_NAME:$$IMAGE_TAG