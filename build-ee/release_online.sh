#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

TMP_DIR="/tmp/dbagent"

. "${BUILD_DIR}/utils.sh"

function publish_package() {
  
  FILE_NAME="dbagent-installer-${VERSION}"
  RELEASE_DIR="${TMP_DIR}/${FILE_NAME}"
  echo "[RELEASE_DIR] ${RELEASE_DIR}"
  
  rm -rf "${RELEASE_DIR:?}"/*
  mkdir -p "${RELEASE_DIR}"

  cp -R . "${RELEASE_DIR}"

  rm -rf "${RELEASE_DIR}/build"
  rm -rf "${RELEASE_DIR}/build-ee"
  rm -rf "${RELEASE_DIR}/.git"
  rm -rf "${RELEASE_DIR}/images" 

  if [[ -n ${VERSION} ]]; then
    sed -i "s@VERSION=.*@VERSION=\"${VERSION}\"@g" "${RELEASE_DIR}/global.env"
  fi
  sed -i "s@flyway_locations=.*@flyway_locations=db/migration@g" "${RELEASE_DIR}/yml/init-db.yml"
  sed -i "s@flyway_locations=.*@flyway_locations=db/migration@g" "${RELEASE_DIR}/yml/smartdata-admin.yml"

  cd ${TMP_DIR}
  tar -cvf "${FILE_NAME}.tar" ${FILE_NAME}
  
  cd ${BUILD_DIR}
  check_dir "${DOWNLOAD_DIR}/${VERSION}"
  
  publish_download_server "${RELEASE_DIR}.tar"
  
  mv "${RELEASE_DIR}.tar" "${DOWNLOAD_DIR}/${VERSION}"

  rm -rf "${RELEASE_DIR}"
}

function main() {

  echo "[Start] SmartDB online publish"
  echo "[VERSION] ${VERSION}"
  # echo "[RELEASE_DIR] ${RELEASE_DIR}"
  
  publish_package
  
  echo "[Done] SmartDB online package has been completed"
}
main
