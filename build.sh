#!/bin/sh
apt-get update
apt-get install git curl wget libxml2 libssl-dev libpython2.7 clang uuid-dev libcurl4-openssl-dev openssl -y
TOOLCHAIN_TYPE=swift-3.1.1-release
TOOLCHAIN_VERSION=swift-3.1.1-RELEASE
UBUNTU_SHORT_VERSION=1604
UBUNTU_VERSION=16.04
wget https://swift.org/builds/${TOOLCHAIN_TYPE}/ubuntu${UBUNTU_SHORT_VERSION}/${TOOLCHAIN_VERSION}/${TOOLCHAIN_VERSION}-ubuntu${UBUNTU_VERSION}.tar.gz
tar -zxf ${TOOLCHAIN_VERSION}-ubuntu${UBUNTU_VERSION}.tar.gz
mv ${TOOLCHAIN_VERSION}-ubuntu${UBUNTU_VERSION} /usr/swift
export PATH=/usr/swift/usr/bin:"${PATH}"
swift build
