#!/bin/bash

# https://facebook.github.io/watchman/docs/install.html
apt-get -yq install autoconf automake build-essential python-dev
git clone https://github.com/facebook/watchman.git /tmp/watchman
cd /tmp/watchman
git checkout v3.9.0       # ember-cli
./autogen.sh
./configure
make install

# https://segmentfault.com/a/1190000005748046
echo 256 | tee -a /proc/sys/fs/inotify/max_user_instances
echo 32768 | tee -a /proc/sys/fs/inotify/max_queued_events
echo 65536 | tee -a /proc/sys/fs/inotify/max_user_watches
watchman shutdown-server
