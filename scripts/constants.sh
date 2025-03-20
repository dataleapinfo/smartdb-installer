#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

export SCRIPT_DIR="$BASE_DIR"
PROJECT_DIR=$(dirname "${SCRIPT_DIR}")

if [[ ! "$(echo $PATH | grep /usr/local/bin)" ]]; then
  export PATH=/usr/local/bin:$PATH
fi

GLOBAL_ENV=${PROJECT_DIR}/global.env
. "${GLOBAL_ENV}"

export COPYRIGHT="Copyright (c) 2025 DataLeap Info Tech Co., Ltd. All rights reserved."

export CONFIG_DIR=${GLOBAL_CONFIG_DIR}
export CONFIG_ENV=$CONFIG_DIR/.env

export REGISTRY="registry.cn-hangzhou.aliyuncs.com"
export PUBLIC_IMAGE_PREFIX="dataleapinfo"

export OS=$(uname -s)
export DOCKER_VERSION=27.4.0
export DOCKER_MIRROR="https://mirrors.aliyun.com/docker-ce/linux/static/stable"

export DOCKER_COMPOSE_VERSION=v2.31.0
export DOCKER_COMPOSE_MIRROR="https://download.jumpserver.org/docker/compose/releases/download"

ARCH=$(uname -m)
if [ -n "${BUILD_ARCH}" ]; then
  ARCH=${BUILD_ARCH}
fi

export ARCH
export DOCKER_BIN_URL="${DOCKER_MIRROR}/${ARCH}/docker-${DOCKER_VERSION}.tgz"
export DOCKER_COMPOSE_BIN_URL="${DOCKER_COMPOSE_MIRROR}/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${ARCH}"
