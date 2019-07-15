#!/bin/bash -eux

export PYTHON_VERSION="3.7.4"

if [ -x "$(command -v apt-get)" ]; then
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get upgrade -yq
    apt-get install -yq aptitude git wget curl build-essential zlib1g-dev \
      libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev \
      libffi-dev libsqlite3-dev
fi

if [ -x "$(command -v yum)" ]; then
    yum update -y
    yum install -y yum-utils git wget curl make gcc openssl-devel bzip2-devel \
      libffi-devel sqlite-devel
fi

# install Python
cd /tmp
wget https://www.python.org/ftp/python/$PYTHON_VERSION/Python-$PYTHON_VERSION.tar.xz
tar xf Python-$PYTHON_VERSION.tar.xz
cd Python-$PYTHON_VERSION
./configure
make && make install
ln -sf /usr/local/bin/python3.7 /usr/bin/python
python --version

# install Pip    
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip --version
