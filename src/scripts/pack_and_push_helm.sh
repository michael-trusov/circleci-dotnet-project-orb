#!/bin/bash
#shellcheck disable=all

helmRepoArtifact="${HELM_REPO}/${HELM_CHART_NAME}:${HELM_CHART_VERSION}"

# package and publish helm chart
helm version
helm registry login $CONTAINER_REGISTRY_URL --username $CONTAINER_REGISTRY_USERNAME --password $CONTAINER_REGISTRY_PASSWORD
helm package --app-version="${HELM_CHART_NAME}:${HELM_CHART_VERSION}" --version=1.0.0 k8s/helm/$HELM_CHART_NAME
helm chart save "${HELM_CHART_NAME}-1.0.0.tgz" $helmRepoArtifact
helm chart push $helmRepoArtifact