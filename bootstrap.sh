#!/bin/sh

gem list | grep ^r10k >/dev/null

if [[ $? -ne 0 ]]; then
  gem install --no-rdoc --no-ri r10k
fi
