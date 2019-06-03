#!/bin/bash -eux

# ensure that ENV VARs are set
export DOCKER_USERNAME=${DOCKER_USERNAME:=$(whoami)}
export PACKAGE=${PACKAGE:=python3}
export PACKAGE_VERSION=${PACKAGE_VERSION:=3.7.3}

./build_packer_docker_ubuntu16.04.sh
./build_packer_docker_centos7.6.sh
