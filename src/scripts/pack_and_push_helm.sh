#!/bin/bash
#shellcheck disable=all

debug_message() {
    local message=$1

    if [[ "${INPUT_PARAM_DEBUG}" == "true" ]]; then
        echo "[DEBUG] $message"
    fi
}

if [ -z "$HELM_CHART_VERSION" ]; then
    if [ -z "${INPUT_TAG_FILE}" ]; then
        debug_message "IMAGE_TAG is not specified and file with tag information is not provided."
        exit 1
    elif [ ! -f "${INPUT_TAG_FILE}" ]; then
        debug_message "INPUT_TAG_FILE '${INPUT_TAG_FILE}' does not exist."
        exit 1
    else
        HELM_CHART_VERSION=$(tr -d ' ' < "${INPUT_TAG_FILE}")
        # Remove the 'v' prefix if it exists
        HELM_CHART_VERSION=${HELM_CHART_VERSION//v}
        debug_message "HELM_CHART_VERSION is set to '${HELM_CHART_VERSION}' from file '${INPUT_TAG_FILE}'."
    fi
fi


helmRepoArtifact="${HELM_REPO}/${HELM_CHART_NAME}:${HELM_CHART_VERSION}"

# package and publish helm chart
helm version
helm registry login $ACR_URL --username $ACR_USERNAME --password $ACR_PASSWORD
helm package --app-version="${HELM_CHART_NAME}:${HELM_CHART_VERSION}" --version=1.0.0 ${HELM_CHART_DESTINATION}/${HELM_CHART_NAME}
helm chart save "${HELM_CHART_NAME}-1.0.0.tgz" $helmRepoArtifact
helm chart push $helmRepoArtifact
