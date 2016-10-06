#!/bin/bash

# https://facebook.github.io/watchman/docs/install.html
apt-get -yq install autoconf automake build-essential python-dev
git clone https://github.com/facebook/watchman.git /tmp/watchman
cd /tmp/watchman
git checkout v3.9.0       # ember-cli
./autogen.sh
./configure
make install
