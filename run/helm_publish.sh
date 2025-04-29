#!/usr/bin/env bash
set -e

# get directory of chart folder
CHART_DIR=$(dirname "$0")/..
PACKAGE_FOLDER=${CHART_DIR}/package
TAG_VERSION=$(yq -r '.version' "${CHART_DIR}"/Chart.yaml)

echo "login into helm repository $HELM_LOGIN_URL"
echo $NEXUS_PASSWORD | helm registry login "${HELM_LOGIN_URL}" --username $NEXUS_USERNAME --password-stdin

# Push the chart to the registry
echo "Publishing chart to ${HELM_REPO}"
helm push "${PACKAGE_FOLDER}/${IMAGE_NAME}-${TAG_VERSION}.tgz" "${HELM_REPO}"
