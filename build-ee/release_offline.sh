#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

TMP_DIR="/tmp/dbagent"
# RELEASE_DIR="${TMP_DIR}/offline"

. "${BUILD_DIR}/utils.sh"

function download_and_verify() {
  local url=$1
  local target_path=$2

  parent_dir=$(dirname "${target_path}")
  check_dir ${parent_dir}

  if [[ ! -f "${target_path}" ]]; then
    echo "Starting to download: ${url}"
    wget -q "${url}" -O "${target_path}" || {
      echo "Download fails, check the network is normal"
      rm -f "${target_path}"
      exit 1
    }
  else
    echo "Using cache: ${target_path}"
  fi
}
function download() {
  
  check_dir ${CACHE_DIR}
  download_and_verify "${DOCKER_BIN_URL}" "${CACHE_DIR}/docker.tar.gz"
  download_and_verify "${DOCKER_COMPOSE_BIN_URL}" "${CACHE_DIR}/docker-compose"
  
  if [[ ! -f "${PROJECT_DIR}/public/docker/docker.tar.gz" ]]; then
    cp -R "${CACHE_DIR}/docker.tar.gz" "${PROJECT_DIR}/public/docker/docker.tar.gz"
  fi
  if [ ! -f "${PROJECT_DIR}/public/docker/docker-compose" ]; then
    cp -R "${CACHE_DIR}/docker-compose" "${PROJECT_DIR}/public/docker/docker-compose"
    chmod +x "${PROJECT_DIR}/public/docker/docker-compose"
  fi
}


function publish_package() {
  FILE_NAME="dbagent-offline-${VERSION}"
  RELEASE_DIR="${TMP_DIR}/${FILE_NAME}"
  echo "[RELEASE_DIR] ${RELEASE_DIR}"

  rm -rf "${RELEASE_DIR:?}"/*
  mkdir -p "${RELEASE_DIR}"

  cp -R . "${RELEASE_DIR}"

  rm -rf "${RELEASE_DIR}/build"
  rm -rf "${RELEASE_DIR}/build-ee"
  rm -rf "${RELEASE_DIR}/.git"

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

  echo "[Start] SmartDB offline publish"
  echo "[VERSION] ${VERSION}"
  # echo "[RELEASE_DIR] ${RELEASE_DIR}"
 
  download
  publish_package 
  
  echo "[Done] SmartDB offline package has been completed"
}
main
