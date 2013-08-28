#!/bin/sh
[[ $(rpm -qa | grep ^git-) ]] || (yum install -y -q git && sleep 5)
[[ $(gem query -i -n r10k) ]] || gem install --no-rdoc --no-ri r10k
cd /vagrant && r10k -v info puppetfile install
