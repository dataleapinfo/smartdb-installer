#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

TMP_DIR="/tmp/smartdb"
RELEASE_DIR="${TMP_DIR}/online"

. "${BUILD_DIR}/constants.sh"

function publish_package() {
  rm -rf "${RELEASE_DIR:?}"/*

  mkdir -p "${RELEASE_DIR}"

  cp -R . "${RELEASE_DIR}"

  rm -rf "${RELEASE_DIR}/build"
  rm -rf "${RELEASE_DIR}/.git"
  rm -rf "${RELEASE_DIR}/images" 

  if [[ -n ${VERSION} ]]; then
    sed -i "s@VERSION=.*@VERSION=\"${VERSION}\"@g" "${RELEASE_DIR}/global.env"
  fi
  FILE_NAME="${TMP_DIR}/smartdb-installer-${VERSION}.tar.gz"
  tar -cvf ${FILE_NAME} ${RELEASE_DIR}
  
  if [[ ! -d "${DOWNLOAD_DIR}/${VERSION}" ]]; then
    mkdir -p "${DOWNLOAD_DIR}/${VERSION}"
  fi
  mv ${FILE_NAME} "${DOWNLOAD_DIR}/${VERSION}"
  
  rm -rf "${RELEASE_DIR}"
}

function main() {

  echo "[Start] SmartDB online publish"
  echo "[VERSION] ${VERSION}"
  echo "[RELEASE_DIR] ${RELEASE_DIR}"
  
  publish_package
  
  echo "[Done] SmartDB online package has been completed"
}
main
