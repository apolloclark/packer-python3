# packer-python3

Packer, Ansible, Serverspec, project to create Python 3.x VM, AWS AMI, and Docker images.

## Requirements

- Packer
- Ansible
- [Serverspec](https://serverspec.org/): gem install serverspec
- [docker-api](https://github.com/swipely/docker-api/releases): gem install docker-api

## Install
```shell
git clone https://github.com/apolloclark/packer-python3
cd ./packer-python3

# set your Docker hub username
export DOCKER_USERNAME="apolloclark" # $(whoami)

# ./all.sh
./build_packer_docker.sh
```

## Build Details

```shell
Python 3.7.2, 2018-12-24
https://www.python.org/downloads/
```