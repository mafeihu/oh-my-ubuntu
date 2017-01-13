#!/bin/bash

sudo apt-key adv \
       --keyserver hkp://ha.pool.sks-keyservers.net:80 \
       --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" \
    | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates \
    linux-image-extra-$(uname -r) linux-image-extra-virtual \
    docker-engine


sudo tee /etc/docker/daemon.json << EOD
{
  "registry-mirror": ["https://ep1dz7wh.mirror.aliyuncs.com"]
}
EOD

sudo usermod -aG docker $USER
sudo reboot
