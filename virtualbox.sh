#!/bin/bash

# Doc: https://mirrors.tuna.tsinghua.edu.cn/help/virtualbox/

# VirtualBox
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | \
      apt-key add -
echo  "deb https://mirrors.tuna.tsinghua.edu.cn/virtualbox/apt/ xenial contrib" | \
      tee -a /etc/apt/sources.list.d/virtualbox.list
apt-get update && -yq apt-get install virtualbox-5.1


# VirtualBox Extension Pack
version=`echo $(VBoxManage -v) | awk '{split($0, version, "r"); print version[1]}'`
release=`echo $(VBoxManage -v) | awk '{split($0, version, "r"); print version[2]}'`
extpack=Oracle_VM_VirtualBox_Extension_Pack-$version-$release.vbox-extpack
curl -o /tmp/$extpack http://download.virtualbox.org/virtualbox/$version/$extpack
VBoxManage extpack install --replace /tmp/$extpack
