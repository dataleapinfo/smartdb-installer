#!/usr/bin/env bash

BUILD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PROJECT_DIR=$(dirname "${BUILD_DIR}")

cd "${PROJECT_DIR}" || exit 1

. "${BUILD_DIR}/utils.sh"

TMP_DIR="${BUILD_DIR}/tmp"

IMAGE_DIR="${PROJECT_DIR}/images"

function save_image() {
  IMAGE="${REGISTRY}/$1"

  if [[ -z "$IMAGE" ]]; then
    echo "Image is null pass"
    return 1
  fi

  echo 
  echo "pull image: $IMAGE"
  if ! docker pull "$IMAGE"; then
    echo "[ERROR] pull image: $IMAGE, pass"
    exit 1
  fi
  
  IMAGE_TAG=$(echo "$IMAGE" | sed -E 's|^.+/([^/]+/[^:]+:[^:]+)$|\1|')
  IMAGE_TAG=$(get_image_name_replace_tag "$IMAGE_TAG")
  SAFE_NAME=$(basename "$IMAGE_TAG" | tr '/:' '_')
  
  echo "tag image: -> $IMAGE_TAG"
  docker tag "$IMAGE" "$IMAGE_TAG"
  
  docker tag "$IMAGE" "${REGISTRY}/$IMAGE_TAG"
  docker push "${REGISTRY}/$IMAGE_TAG" 
  
  docker tag "$IMAGE" "${PUBLISH_ALIYUN_REGISTRY}/$IMAGE_TAG"
  docker push "${PUBLISH_ALIYUN_REGISTRY}/$IMAGE_TAG" 
  
  echo
  echo "save image: $TMP_DIR/${SAFE_NAME}.tar"
  docker save "$IMAGE_TAG" -o "$TMP_DIR/${SAFE_NAME}.tar"

  echo
  echo "Get md5: ${IMAGE}"
  docker inspect -f "{{.ID}}" "${IMAGE}" > "$TMP_DIR/${SAFE_NAME}.tar.zst.md5"
  
  echo
  echo "compress image: -> "
  zstd -19 "$TMP_DIR/${SAFE_NAME}.tar"
  
  docker rmi "$IMAGE"
  docker rmi "$IMAGE_TAG"

  docker rmi "${REGISTRY}/$IMAGE_TAG"
  docker rmi "${PUBLISH_ALIYUN_REGISTRY}/$IMAGE_TAG"

  rm -rf "$TMP_DIR/${SAFE_NAME}.tar"
  return 0
}

function pull_images() {
  local images=("$@")
  echo "[Pull] Total Images: ${#images[@]}"
  for image in "${images[@]}"; do
    save_image "$image" || echo "[Pass] image error: $image"
  done
   
  check_dir "$IMAGE_DIR"
  mv "$TMP_DIR"/* "$IMAGE_DIR" || echo "[ERROR] Unable to move file, please check manually." 
}

function save_public_image() {
  IMAGE="${REGISTRY}/$1"

  if [[ -z "$IMAGE" ]]; then
    echo "Image is null pass"
    return 1;
  fi

  echo 
  echo "Pull image: $IMAGE"
  if ! docker pull "$IMAGE"; then
    echo "[ERROR] pull image: $IMAGE, pass"
  fi
  IMAGE_TAG=$(echo "$IMAGE" | cut -d '/' -f3)
  SAFE_NAME=$(echo "$IMAGE_TAG" | tr '/:' '_')
  
  image_id=$(docker inspect -f "{{.ID}}" "${IMAGE}" 2&>/dev/null || echo "")

  echo "Tag image: -> $IMAGE_TAG"
  docker tag "$IMAGE" "$IMAGE_TAG"
  
  echo
  echo "Save image: $CACHE_DIR/${SAFE_NAME}.tar"
  docker save "$IMAGE_TAG" -o "$CACHE_DIR/${SAFE_NAME}.tar"
  
  echo
  echo "Get md5: ${IMAGE}"
  docker inspect -f "{{.ID}}" "${IMAGE}" > "$CACHE_DIR/${SAFE_NAME}.tar.zst.md5"

  echo
  echo "Compress image: -> "
  zstd -19 "$CACHE_DIR/${SAFE_NAME}.tar"

  rm "$CACHE_DIR/${SAFE_NAME}.tar"
  return 0
}

function pull_public_images() {
  local images=("$@")
  echo "[Pull] Total public Images: ${#images[@]}"
  if [[ ! -d "$CACHE_DIR" ]]; then
    mkdir -p "$CACHE_DIR"
  fi
  for image in "${images[@]}"; do
    IMAGE_FILE_NAME=$(echo "$image" | cut -d '/' -f2 | sed 's/:/_/')
    IMAGE_FILE_NAME="$IMAGE_FILE_NAME.tar.zst"

    if [[ ! -f "${CACHE_DIR}/${IMAGE_FILE_NAME}" ]]; then
      save_public_image "$image" || echo "[Pass] image error: $image"
    else 
      echo "Using cache: ${CACHE_DIR}/${IMAGE_FILE_NAME}"
    fi
    cp "${CACHE_DIR}/${IMAGE_FILE_NAME}" "$IMAGE_DIR"
    cp "${CACHE_DIR}/${IMAGE_FILE_NAME}.md5" "$IMAGE_DIR"
  done
}

function clear_tmp() {
  echo "[Clean] rm tmp $TMP_DIR"
  rm -rf "$TMP_DIR"
}

function main() {

  echo "[Start] SmartDB preprocessing images"
  echo
  echo "[TMP_DIR] $TMP_DIR"
  echo "[IMAGE_DIR] $IMAGE_DIR"
  if [[  -d "$TMP_DIR" ]] ; then
    rm -rf "$TMP_DIR"
  fi
  mkdir -p "$TMP_DIR"

  IMAGES=(
    "${IMAGE_DBMANAGER_VERSION}"
    "${IMAGE_SMARTDATA_ADMIN_VERSION}"
    "${IMAGE_DBGATE_SERVER_VERSION}"
    "${IMAGE_DBGATE_WEB_VERSION}"
  )

  PUBLIC_IMAGES=(
    "${IMAGE_REDIS_VERSION}"
    "${IMAGE_MYSQL_VERSION}"
    "${IMAGE_EMQX_VERSION}"
    "${IMAGE_NGINX_VERSION}"
  )
  echo
  pull_images "${IMAGES[@]}"
  pull_public_images "${PUBLIC_IMAGES[@]}"
  clear_tmp

  echo "[Done] All images have beed saved to: $IMAGE_DIR"
}

main
