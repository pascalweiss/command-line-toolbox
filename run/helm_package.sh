#!/usr/bin/env bash
set -e

# get directory of chart folder
CHART_DIR=$(dirname "${0}")/..
PACKAGE_FOLDER="${CHART_DIR}"/package

# Create the package folder if it doesn't exist
mkdir -p "${PACKAGE_FOLDER}"

# Package the Helm chart and specify the package folder
helm package "${CHART_DIR}" --destination "${PACKAGE_FOLDER}"
