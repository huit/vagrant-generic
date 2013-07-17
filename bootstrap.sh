#!/bin/sh

yum install -y git

gem list | grep ^r10k >/dev/null

if [[ $? -ne 0 ]]; then
  gem install --no-rdoc --no-ri r10k
fi

cd /vagrant && r10k puppetfile install
