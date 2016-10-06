#!/bin/bash

# GitHub
GITHUB="https://github.com"
checkout() {
  [ -d "$2" ] || git clone --depth 1 "$1" "$2"
}

# initialze
NVM_DIR=/usr/local/nvm

# nvm
checkout "${GITHUB}/creationix/nvm.git"            "${NVM_DIR}"

tee /etc/profile.d/nvm.sh << EOD
export NVM_NODEJS_ORG_MIRROR=http://npm.taobao.org/mirrors/node
export NVM_DIR=$NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
EOD
source /etc/profile.d/nvm.sh

# node
nvm install node
nvm use node

# npm
npm config set registry https://registry.npm.taobao.org
npm install -g react-native-cli
npm install -g ember-cli
npm install -g express-generator
npm install -g bower


# Fix Permissions
chgrp -R adm $NVM_DIR
chmod -R g+rwx $NVM_DIR

# vagrant
if [ -d /home/vagrant ]; then
  usermod -a -G adm vagrant
  su - vagrant -c "npm config set registry https://registry.npm.taobao.org"
fi

#tips
echo '--------------Config Local User-----------------------------'
echo 'npm config set registry https://registry.npm.taobao.org'
echo '------------------------------------------------------------'
