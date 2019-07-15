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

# build with bash
./build_packer_docker.sh



# clean up ALL previous builds
./clean_packer_docker.sh

# Gradle, clean up previous builds, from today
gradle clean --parallel --project-dir gradle-build

# Gradle, build all images, in parallel
gradle testBash --parallel --project-dir gradle-build

# Gradle, build all images, in parallel, forced rebuild
gradle testBash --parallel --rerun-tasks --project-dir gradle-build

# Gradle, build only specific OS images
gradle ubuntu18.04:testBash --project-dir gradle-build
gradle ubuntu16.04:testBash --project-dir gradle-build
gradle centos7:testBash --project-dir gradle-build

# Gradle, build only specific OS images, forced rebuild
gradle ubuntu18.04:testBash --rerun-tasks --project-dir gradle-build
gradle ubuntu16.04:testBash --rerun-tasks --project-dir gradle-build
gradle centos7:testBash --rerun-tasks --project-dir gradle-build

# Gradle, build only specific OS images
gradle ubuntu18.04:testBash --project-dir gradle-build --dry-run
gradle ubuntu16.04:testBash --project-dir gradle-build --dry-run
gradle centos7:testBash --project-dir gradle-build --dry-run
```

## Build Details

```shell
Python 3.7.4, 2019-07-08
https://www.python.org/downloads/
```