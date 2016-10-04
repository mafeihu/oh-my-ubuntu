#!/bin/bash

# initialize
GEM_SOURCES_CHINA=https://gems.ruby-china.org/
GEM_SOURCES_ORIGIN=https://gems.ruby-china.org/
export RUBY_BUILD_MIRROR_URL=http://oeijhg095.bkt.clouddn.com
export RUBY_CONFIGURE_OPTS="--disable-install-doc"

echo -n "please input version: "
read ruby_version

# Rbenv
apt-get -yq install autoconf bison build-essential libssl-dev libyaml-dev \
                    libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev \
                    libgdbm3 libgdbm-dev
git clone https://github.com/sstephenson/rbenv.git /usr/local/rbenv
git clone https://github.com/sstephenson/ruby-build.git \
          /usr/local/rbenv/plugins/ruby-build


# Rbenv profile
tee /etc/profile.d/rbenv.sh << EOD
# rbenv setup
export RBENV_ROOT=/usr/local/rbenv
export PATH="\$RBENV_ROOT/bin:\$PATH"
eval "\$(rbenv init -)"
EOD
source /etc/profile.d/rbenv.sh
echo -e "\e[31;43;1m Rbenv install success \e[0m "


# Ruby
rbenv install -kvs $ruby_version
rbenv global $ruby_version
rbenv shell $ruby_version
echo -e "\e[31;43;1m Ruby install success \e[0m "

# Gem
CHECK_GEM_SOURCES=$(gem sources | grep $GEM_SOURCES_CHINA | wc -l)
if [ ! $CHECK_GEM_SOURCES -ge 1 ]; then
  gem sources --add $GEM_SOURCES_CHINA --remove $GEM_SOURCES_ORIGIN
  echo 'gem: --no-document' | tee -a ~/.gemrc
fi

# bundler
gem install bundler
bundle config mirror.${GEM_SOURCES_ORIGIN%/} ${GEM_SOURCES_CHINA%/}

# framework
gem install rails
gem install sinatra

# Fix Permissions
chgrp -R adm /usr/local/rbenv
chmod -R g+rwx /usr/local/rbenv
