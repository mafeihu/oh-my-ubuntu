#!/bin/bash

# GitHub
GITHUB="https://github.com"
checkout() {
  [ -d "$2" ] || git clone --depth 1 "$1" "$2"
}

# initialize
RUBY_VERSION=3.5.2
PYPI_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
export PYENV_ROOT=/usr/local/pyenv
export PYTHON_BUILD_MIRROR_URL='http://oej2vuvzj.bkt.clouddn.com'

# pyenv
apt-get -yq install make build-essential libssl-dev zlib1g-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev wget curl llvm \
                    libncurses5-dev libncursesw5-dev xz-utils

checkout "${GITHUB}/yyuu/pyenv.git"            "${PYENV_ROOT}"
checkout "${GITHUB}/yyuu/pyenv-doctor.git"     "${PYENV_ROOT}/plugins/pyenv-doctor"
checkout "${GITHUB}/yyuu/pyenv-installer.git"  "${PYENV_ROOT}/plugins/pyenv-installer"
checkout "${GITHUB}/yyuu/pyenv-update.git"     "${PYENV_ROOT}/plugins/pyenv-update"
checkout "${GITHUB}/yyuu/pyenv-virtualenv.git" "${PYENV_ROOT}/plugins/pyenv-virtualenv"
checkout "${GITHUB}/yyuu/pyenv-which-ext.git"  "${PYENV_ROOT}/plugins/pyenv-which-ext"

tee /etc/profile.d/pyenv.sh << EOD
# Load pyenv automatically
export PYENV_ROOT=$PYENV_ROOT
export PATH="\$PYENV_ROOT/bin:\$PATH"
eval "\$(pyenv init -)"
eval "\$(pyenv virtualenv-init -)"
EOD
source /etc/profile.d/pyenv.sh
echo -e "\e[31;43;1m pyenv install success \e[0m "

# Python
pyenv install -kvs $RUBY_VERSION
pyenv global $RUBY_VERSION
pyenv shell $RUBY_VERSION
pyenv rehash

# pip
echo '--------------Config Local User-----------------------------'
tee /tmp/pip.conf << EOD
[global]
index-url = $PYPI_INDEX_URL
[install]
use-mirrors = true
mirrors = ${PYPI_INDEX_URL%/simple}
EOD
echo '------------------------------------------------------------'

mkdir ~/.pip
cp /tmp/pip.conf ~/.pip/pip.conf
pip install --upgrade pip


# Vagrant
if [ -d /home/vagrant ]; then
  usermod -a -G adm vagrant
  su - vagrant -c "mkdir ~/.pip"
  su - vagrant -c "cp /tmp/pip.conf ~/.pip/pip.conf"
fi

# Fix Permissions
chgrp -R adm $PYENV_ROOT
chmod -R g+rwx $PYENV_ROOT
