#!/bin/bash

dir="$1"
[ -n "$dir" ] || dir='.'

echo Installing Gist gem
gem install gist

log_files=$(find "$dir" -name '*.log')

echo Removing colors from Rails logs
IFS=$'\n' sed -i 's,\x1B\[[0-9;]*[a-zA-Z],,g' $log_files

echo Splitting files
IFS=$'\n'
for f in $log_files; do
    split -b 1M "$f" "$f."
done
unset IFS

echo Writing files to Gist
log_files=$(find "$dir" -name '*.log.*')
desc="Mezuro Travis Logs - $TRAVIS_REPO_SLUG - Build #$TRAVIS_BUILD"
IFS=$'\n' gist --private -d  "$desc" $log_files
