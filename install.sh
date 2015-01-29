#!/bin/bash
# Script to install Kalibro Service and dependencies on Ubuntu 12.04.
# It may work on Debian 6 but this is untested.
#
# This script assumes a sane enviroment with at least the following
# depedencies already installed and configured:
# -sudo
#	-wget
#	-coreutils
# -RVM with Kalibro's Ruby version already installed (See rvm.io)
# -Postgresql

# Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail
IFS=$'\n\t'

# Set script configuration
ANALIZO_VERSION='1.17.0' # Version >1.17.0 needs Ubuntu 13.10/Debian 7

# Kalibro dependencies (including Analizo)
sudo bash -c "echo \"deb http://analizo.org/download/ ./\" > /etc/apt/sources.list.d/analizo.list"
sudo bash -c "echo \"deb-src http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
wget -O - http://analizo.org/download/signing-key.asc | sudo apt-key add -
sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y analizo=${ANALIZO_VERSION} subversion git

# Kalibro Processor
git clone https://github.com/mezuro/kalibro_processor.git -b v0.3.0.rc1 kalibro_processor
pushd kalibro_processor
psql -c "create role kalibro_processor with createdb login password 'kalibro_processor'" -U postgres
cp config/database.yml.postgresql_sample config/database.yml
cp config/repositories.yml.sample config/repositories.yml
export BUNDLE_GEMFILE=$PWD/Gemfile
bundle install --retry=3
RAILS_ENV=local bundle exec rake db:setup db:migrate
RAILS_ENV=local bundle exec rails s -p 8082 -d
RAILS_ENV=local bundle exec bin/delayed_job start
popd
export BUNDLE_GEMFILE=""

# Kalibro Configurations
git clone https://github.com/mezuro/kalibro_configurations.git -b v0.0.1.rc1 kalibro_configurations
pushd kalibro_configurations
cp config/database.yml.sample config/database.yml
export BUNDLE_GEMFILE=$PWD/Gemfile
bundle install --retry=3
bundle exec rake db:setup db:migrate
bundle exec rails s -p 8083 -d
popd
export BUNDLE_GEMFILE=""
