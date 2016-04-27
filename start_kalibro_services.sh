#!/bin/bash

# Bash unofficial strict mode: http://www.redsymbol.net/articles/unofficial-bash-strict-mode/
set -e
set -o pipefail
IFS=$'\n\t'

pushd kalibro_processor
  export BUNDLE_GEMFILE=$PWD/Gemfile
  RAILS_ENV=local bundle exec rails s -p 8082 -d
  RAILS_ENV=local bundle exec bin/delayed_job start
  unset BUNDLE_GEMFILE BUNDLE_PATH
popd

pushd kalibro_configurations
  export BUNDLE_GEMFILE=$PWD/Gemfile
  bundle exec rails s -p 8083 -d
  unset BUNDLE_GEMFILE BUNDLE_PATH
popd
