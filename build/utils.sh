#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BUILD_DIR}/constants.sh"

REMOTE_HOST="root@115.175.16.229"
REMOTE_DIR="/usr/local/dataleap/download/dbagent"

function check_dir() {
  dir=$1
  if [[ ! -d "${dir}" ]]; then
    mkdir -p "${dir}"
  fi
}

function get_image_name_replace_tag() {
  image="$1"
  prefix=$(echo "$image" | cut -d':' -f1)
  new_image="$prefix:${VERSION}"
  echo "$new_image"
}

function publish_download_server() {
  FILE_NAME=$1
  ssh "${REMOTE_HOST}" "mkdir -p ${REMOTE_DIR}/${VERSION}"
  scp "${TMP_DIR}/${FILE_NAME}.tar" "${REMOTE_HOST}:${REMOTE_DIR}/${VERSION}" 
}

