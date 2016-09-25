#!/bin/bash

# initialize
RUBY_VERSION=2.3.1
GEM_SOURCES=https://gems.ruby-china.org/
export RUBY_BUILD_MIRROR_URL=https://ruby.taobao.org/mirrors/ruby/ruby-$RUBY_VERSION.tar.bz2#
export RUBY_CONFIGURE_OPTS="--disable-install-doc"

# Rbenv
apt-get -yq install autoconf bison build-essential libssl-dev libyaml-dev \
                    libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev \
                    libgdbm3 libgdbm-dev
git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
git clone https://github.com/sstephenson/ruby-build.git \
          /usr/local/rbenv/plugins/ruby-build

echo '# rbenv setup' >> /etc/profile.d/rbenv.sh
echo 'export RBENV_ROOT=/usr/local/rbenv'  >> /etc/profile.d/rbenv.sh
echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /etc/profile.d/rbenv.sh
echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
source /etc/profile.d/rbenv.sh
echo -e "\e[31;43;1m Rbenv install success \e[0m "


# Ruby
rbenv install $RUBY_VERSION
rbenv global $RUBY_VERSION
rbenv shell $RUBY_VERSION
rbenv rehash
echo -e "\e[31;43;1m Ruby install success \e[0m "

# Rails
gem sources --add $GEM_SOURCES --remove https://rubygems.org/ -V
echo 'gem: --no-document' >> ~/.gemrc
gem install rails
echo -e "\e[31;43;1m $(rails -v) install success \e[0m "

# Fix Permissions
chgrp -R adm /usr/local/rbenv
chmod -R g+rwx /usr/local/rbenv
