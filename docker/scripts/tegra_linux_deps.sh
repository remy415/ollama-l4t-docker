#!/bin/sh

# Script for common Dockerfile dependency installation in Tegra L4T based images
CURL_OPTIONS="-s -L"
if [ -n "JETSON_DBUILD_PROXY" ]; then
    CURL_OPTIONS="${CURL_OPTIONS} -x ${JETSON_DBUILD_PROXY}"
fi
set -ex
MACHINE=$(uname -m)

if grep -i "ubuntu" /etc/os-release >/dev/null; then
    # Tegra L4T 35.x images are Ubuntu 20.04-based, L4T 36.x images are Ubuntu 22.04-based

    if [ "${MACHINE}" = "aarch64" ]; then
        add-apt-repository ppa:git-core/ppa
        add-apt-repository ppa:ubuntu-toolchain-r/test
        apt update && apt -y install git-all gcc-10 g++-10
    fi
else
    echo "ERROR Unexpected distro"
    exit 1
fi

if [ -n "${CMAKE_VERSION}" ]; then
    curl ${CURL_OPTIONS} https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-linux-$(uname -m).tar.gz | tar -zx -C /usr --strip-components 1
    rm /usr/local/bin/cmake && update-alternatives --install /usr/local/bin/cmake cmake /usr/bin/cmake 30
fi

if [ -n "${GOLANG_VERSION}" ]; then
    GO_ARCH="arm64"
    mkdir -p /usr/local
    curl ${CURL_OPTIONS} https://dl.google.com/go/go${GOLANG_VERSION}.linux-${GO_ARCH}.tar.gz | tar xz -C /usr/local
    ln -s /usr/local/go/bin/go /usr/local/bin/go
    ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt
fi
