#!/bin/bash
#shellcheck disable=all

### Description
###   This function print message if INPUT_PARAM_DEBUG is set to 'true'
###
### Parameters:
###   $1 - message
debug_message() {
    local message=$1

    if [[ "${INPUT_PARAM_DEBUG}" == "true" ]]; then
        echo "[DEBUG] $message"
    fi
}

if [ -z "$IMAGE_TAG" ]; then
    if [ -z "${INPUT_TAG_FILE}" ]; then
        debug_message "IMAGE_TAG is not specified and file with tag information is not provided."
        exit 1
    elif [ ! -f "${INPUT_TAG_FILE}" ]; then
        debug_message "INPUT_TAG_FILE '${INPUT_TAG_FILE}' does not exist."
        exit 1
    else
        IMAGE_TAG=$(tr -d ' ' < "${INPUT_TAG_FILE}")
        debug_message "IMAGE_TAG is set to '${IMAGE_TAG}' from file '${INPUT_TAG_FILE}'."
    fi
fi

docker build -f ${DOCKERFILE} -t ${ACR_URL}/${IMAGE_NAME}:${IMAGE_TAG} ${DOCKER_CONTEXT}