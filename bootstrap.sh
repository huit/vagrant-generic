#!/bin/sh
# Basic bootstrap script that installs librarian-puppet and uses it to fetch
# Puppet modules. This script assumes a RedHat-derived distribution.

if [ ! -x /usr/bin/git ]; then
  yum install -y -q git-core rubygems ruby-devel gcc
  sleep 4
fi

if [ "$(gem query -i -n librarian-puppet)" != "true" ]; then
  gem install --no-rdoc --no-ri librarian-puppet
  cd /vagrant && librarian-puppet install --clean --verbose
else
  cd /vagrant && librarian-puppet update --verbose
fi
# vim: set ft=sh ts=2 sw=2 ei:
