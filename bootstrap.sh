#!/bin/bash

if [ ! -f /etc/apt/sources.list.default ]; then
  cp /etc/apt/sources.list{,.default}
fi

tee /etc/apt/sources.list << EOD
deb http://cn.archive.ubuntu.com/ubuntu/ xenial main multiverse restricted universe
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-backports main multiverse restricted universe
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-proposed main multiverse restricted universe
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-security main multiverse restricted universe
deb http://cn.archive.ubuntu.com/ubuntu/ xenial-updates main multiverse restricted universe
deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial main multiverse restricted universe
deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-backports main multiverse restricted universe
deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-proposed main multiverse restricted universe
deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-security main multiverse restricted universe
deb-src http://cn.archive.ubuntu.com/ubuntu/ xenial-updates main multiverse restricted universe
EOD

apt-get update && apt-get -yq install  language-pack-zh-hans git-core


# Git
echo -n "Please input your git username: "
read username
echo -n "Please input your git email: "
read email

git config --global user.name "${username}"
git config --global user.email ${email}
git config --global push.default simple
