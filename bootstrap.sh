#!/bin/sh

yum -y update
yum install -y -q git

if [[ "$(gem query -i -n r10k)" == "false" ]]; then
  gem install --no-rdoc --no-ri r10k
fi

cd /vagrant && r10k puppetfile install

# Put in a brief wait before running the Puppet provisioner to clear yum activity
sleep 5
