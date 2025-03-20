#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

TMP_DIR="/tmp/smartdb"
RELEASE_DIR="${TMP_DIR}/offline"

. "${BUILD_DIR}/constants.sh"

function download_and_verify() {
  local url=$1
  local target_path=$2

  parent_dir=$(dirname "${target_path}")
  if [[ ! -d "${parent_dir}" ]]; then
    mkdir -p "${parent_dir}"
  fi

  if [[ ! -f "${target_path}" ]]; then
    echo "Starting to download: ${url}"
    wget -q "${url}" -O "${target_path}" || {
      print_error "Download fails, check the network is normal"
      rm -f "${target_path}"
      exit 1
    }
  else
    echo "Using cache: ${target_path}"
  fi
}
function download() {
  
  if [[ ! -d "${CACHE_DIR}" ]]; then
    mkdir -p "${CACHE_DIR}"
  fi
  download_and_verify "${DOCKER_BIN_URL}" "${CACHE_DIR}/docker.tar.gz"
  download_and_verify "${DOCKER_COMPOSE_BIN_URL}" "${CACHE_DIR}/docker-compose"
  
  if [[ ! -f "${PROJECT_DIR}/public/docker/docker.tar.gz" ]]; then
    cp -R "${CACHE_DIR}/docker.tar.gz" "${PROJECT_DIR}/public/docker/docker.tar.gz"
  fi
  if [ ! -f "${PROJECT_DIR}/public/docker/docker-compose" ]; then
    cp -R "${CACHE_DIR}/docker-compose" "${PROJECT_DIR}/public/docker/docker-compose"
  fi
}

function publish_package() {
  rm -rf "${RELEASE_DIR:?}"/*

  mkdir -p "${RELEASE_DIR}"

  cp -R . "${RELEASE_DIR}"

  rm -rf "${RELEASE_DIR}/build"
  rm -rf "${RELEASE_DIR}/.git"

  if [[ -n ${VERSION} ]]; then
    sed -i "s@VERSION=.*@VERSION=\"${VERSION}\"@g" "${RELEASE_DIR}/global.env"
  fi

  FILE_NAME="${TMP_DIR}/smartdb-offline-${VERSION}.tar.gz"
  tar -cvf ${FILE_NAME} ${RELEASE_DIR}
  
  if [[ ! -d "${DOWNLOAD_DIR}/${VERSION}" ]]; then
    mkdir -p "${DOWNLOAD_DIR}/${VERSION}"
  fi
  mv ${FILE_NAME} "${DOWNLOAD_DIR}/${VERSION}"
  
  rm -rf "${RELEASE_DIR}"
}

function main() {

  echo "[Start] SmartDB offline publish"
  echo "[VERSION] ${VERSION}"
  echo "[RELEASE_DIR] ${RELEASE_DIR}"
 
  download
  publish_package 
  
  echo "[Done] SmartDB offline package has been completed"
}
main
