#!/bin/bash

# GitHub
GITHUB="https://github.com"
checkout() {
  [ -d "$2" ] || git clone --depth 1 "$1" "$2"
}

# initialize
RUBY_VERSION=2.3.1
RBENV_ROOT=/usr/local/rbenv
GEM_SOURCES_CHINA=https://gems.ruby-china.org/
GEM_SOURCES_ORIGIN=https://rubygems.org/
export RUBY_BUILD_MIRROR_URL=http://oeijhg095.bkt.clouddn.com
export RUBY_CONFIGURE_OPTS="--disable-install-doc"


# Rbenv
apt-get -yq install autoconf bison build-essential libssl-dev libyaml-dev \
                    libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev \
                    libgdbm3 libgdbm-dev

checkout "${GITHUB}/sstephenson/rbenv.git"            "${RBENV_ROOT}"
checkout "${GITHUB}/sstephenson/ruby-build.git"       "${RBENV_ROOT}/plugins/ruby-build"

# Rbenv profile
tee /etc/profile.d/rbenv.sh << EOD
# Load rbenv automatically
export RBENV_ROOT=$RBENV_ROOT
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOD
source /etc/profile.d/rbenv.sh
echo -e "\e[31;43;1m Rbenv install success \e[0m "


# Ruby
rbenv install -kvs $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION
rbenv rehash
echo -e "\e[31;43;1m Ruby install success \e[0m "

# Gem
gem sources --add $GEM_SOURCES_CHINA --remove $GEM_SOURCES_ORIGIN -v
echo 'gem: --no-document' | tee -a ~/.gemrc

# bundler
gem install bundler
bundle config mirror.${GEM_SOURCES_ORIGIN%/} ${GEM_SOURCES_CHINA%/}

# framework
gem install rails
gem install sinatra

# Fix Permissions
chgrp -R adm $RBENV_ROOT
chmod -R g+rwx $RBENV_ROOT

# Vagrant
if [ -d /home/vagrant ]; then
  usermod -a -G adm vagrant
  su - vagrant -c "gem sources --add $GEM_SOURCES_CHINA --remove $GEM_SOURCES_ORIGIN -v"
  su - vagrant -c "echo 'gem: --no-document' | tee -a ~/.gemrc"
  su - vagrant -c "bundle config mirror.${GEM_SOURCES_ORIGIN%/} ${GEM_SOURCES_CHINA%/}"
fi

# Tips
echo '--------------Config Local User-----------------------------'
echo "gem sources --add $GEM_SOURCES_CHINA --remove $GEM_SOURCES_ORIGIN -v"
echo "echo 'gem: --no-document' | tee -a ~/.gemrc"
echo "bundle config mirror.${GEM_SOURCES_ORIGIN%/} ${GEM_SOURCES_CHINA%/}"
echo '------------------------------------------------------------'
