#!/bin/bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

. "${BUILD_DIR}/constants.sh"

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

