#!/bin/bash

# initialize
RUBY_VERSION=3.5.2
PYPI_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
export PYENV_ROOT=/usr/local/pyenv
export PYTHON_BUILD_MIRROR_URL='http://oej2vuvzj.bkt.clouddn.com'

# pyenv
apt-get -yq install make build-essential libssl-dev zlib1g-dev libbz2-dev \
                    libreadline-dev libsqlite3-dev wget curl llvm \
                    libncurses5-dev libncursesw5-dev xz-utils

curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

tee /etc/profile.d/pyenv.sh << EOD
# Load pyenv automatically
export PYENV_ROOT="/usr/local/pyenv"
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
mkdir ~/.pip
tee ~/.pip/pip.conf << EOD
[global]
index-url = $PYPI_INDEX_URL
[install]
use-mirrors = true
mirrors = ${PYPI_INDEX_URL%/simple}
EOD
pip install --upgrade pip

# Fix Permissions
chgrp -R adm /usr/local/rbenv
chmod -R g+rwx /usr/local/rbenv
