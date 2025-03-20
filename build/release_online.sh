#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

TMP_DIR="/tmp/smartdb"

. "${BUILD_DIR}/utils.sh"

function publish_package() {
  
  FILE_NAME="smartdb-installer-${VERSION}"
  RELEASE_DIR="${TMP_DIR}/${FILE_NAME}"
  
  rm -rf "${RELEASE_DIR:?}"/*
  mkdir -p "${RELEASE_DIR}"

  cp -R . "${RELEASE_DIR}"

  rm -rf "${RELEASE_DIR}/build"
  rm -rf "${RELEASE_DIR}/.git"
  rm -rf "${RELEASE_DIR}/images" 

  if [[ -n ${VERSION} ]]; then
    sed -i "s@VERSION=.*@VERSION=\"${VERSION}\"@g" "${RELEASE_DIR}/global.env"
  fi

  cd ${TMP_DIR}
  tar -cvf "${FILE_NAME}.tar" ${FILE_NAME}
  
  cd ${BUILD_DIR}
  check_dir "${DOWNLOAD_DIR}/${VERSION}"
  mv "${TMP_DIR}/${FILE_NAME}.tar" "${DOWNLOAD_DIR}/${VERSION}"

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
