#!/bin/bash

# Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -eu
set -o pipefail
IFS=$'\n\t'

# Set script configuration
# Use default from environment if set, otherwise use 1.17.0 since newer versions need Ubuntu 13.10/Debian 7
if [ -z "${ANALIZO_VERSION+x}" ]; then
    ANALIZO_VERSION='1.17.0'
fi

# Kalibro dependencies (including Analizo)
if [ -n "$ANALIZO_VERSION" ]; then
    sudo bash -c "echo \"deb http://analizo.org/download/ ./\" > /etc/apt/sources.list.d/analizo.list"
    sudo bash -c "echo \"deb-src http://analizo.org/download/ ./\" >> /etc/apt/sources.list.d/analizo.list"
    wget -O - http://analizo.org/download/signing-key.asc | sudo apt-key add -
    sudo apt-get update -qq
    sudo DEBIAN_FRONTEND=noninteractive apt-get install -y analizo=${ANALIZO_VERSION} subversion git
fi

# Kalibro Processor
git clone https://github.com/mezuro/kalibro_processor.git -b v0.9.0 kalibro_processor
pushd kalibro_processor
psql -c "create role kalibro_processor with createdb login password 'kalibro_processor'" -U postgres
cp config/database.yml.postgresql_sample config/database.yml
cp config/repositories.yml.sample config/repositories.yml

if [ -n "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR/kalibro_processor/bundle"
    export BUNDLE_PATH="$CACHE_DIR/kalibro_processor/bundle"
fi

export BUNDLE_GEMFILE=$PWD/Gemfile
bundle install --deployment --without="test development" --retry=3
RAILS_ENV=local bundle exec rake db:setup db:migrate
RAILS_ENV=local bundle exec rails s -p 8082 -d
RAILS_ENV=local bundle exec bin/delayed_job start
popd
unset BUNDLE_GEMFILE BUNDLE_PATH

# Kalibro Configurations
git clone https://github.com/mezuro/kalibro_configurations.git -b v0.1.1 kalibro_configurations
pushd kalibro_configurations
psql -c "create role kalibro_configurations with createdb login password 'kalibro_configurations'" -U postgres
cp config/database.yml.postgresql_sample config/database.yml

if [ -n "$CACHE_DIR" ]; then
    mkdir -p "$CACHE_DIR/kalibro_configurations/bundle"
    export BUNDLE_PATH="$CACHE_DIR/kalibro_configurations/bundle"
fi

export BUNDLE_GEMFILE=$PWD/Gemfile
bundle install --deployment --without="test development" --retry=3
bundle exec rake db:setup db:migrate
bundle exec rails s -p 8083 -d
popd
unset BUNDLE_GEMFILE BUNDLE_PATH
