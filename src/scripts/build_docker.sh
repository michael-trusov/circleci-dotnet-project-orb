#!/bin/bash
#shellcheck disable=all

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

if [ -z "$DOCKER_REPOSITORY" ]; then
    debug_message "DOCKER_REPOSITORY is not specified. Value of IMAGE_TAG (${IMAGE_TAG}) will be used."
    
    DOCKER_REPOSITORY=${IMAGE_NAME}
fi


docker build -f ${DOCKERFILE} -t ${ACR_URL}/${DOCKER_REPOSITORY}:${IMAGE_TAG} ${DOCKER_CONTEXT}