#!/bin/bash -eux

export PYTHON_VERSION="3.7.4"

if [ -x "$(command -v apt-get)" ]; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get upgrade -yq
    apt-get install -yq aptitude software-properties-common build-essential \
      nano curl wget git gnupg2 apt-transport-https zlib1g-dev libncurses5-dev \
      libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev libsqlite3-dev
elif [ -x "$(command -v dnf)" ]; then
    dnf makecache
    dnf --assumeyes install yum-utils git wget curl make gcc openssl-devel bzip2-devel \
      libffi-devel sqlite-devel gnupg2 xz tar
    dnf clean all
elif [ -x "$(command -v yum)" ]; then
    yum makecache fast
    yum update -y
    yum install -y yum-utils git wget curl make gcc openssl-devel bzip2-devel \
      libffi-devel sqlite-devel gnupg2 xz tar
    yum clean all
fi



# install Python
cd /tmp
wget -q https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz
tar xf Python-$PYTHON_VERSION.tar.xz
rm -f Python-*.tar.xz
cd Python-$PYTHON_VERSION
./configure
make && make install
ln -sf /usr/local/bin/python3.7 /usr/bin/python
python --version

# install Pip    
curl -sL https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip --version
