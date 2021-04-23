#!/usr/bin/env bash

if [ $# = 1 ]; then
  export DOCKER_ROOT_DIR=$1 #/data/docker
else
  echo
  echo "Usage: $0 path"
  echo
  echo "Example: ./$0 /data/docker"
  exit 1
fi

systemctl stop docker

if [[ ! -d $DOCKER_ROOT_DIR ]]; then
  mkdir $DOCKER_ROOT_DIR
fi

cat <<EoF > /etc/docker/daemon.json
{ 
   "data-root": "${DOCKER_ROOT_DIR}"
}
EoF

rsync -aP /var/lib/docker/ $DOCKER_ROOT_DIR
systemctl start docker
rm -rf /var/lib/docker
docker info | grep 'Root Dir'
