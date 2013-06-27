vagrant-generic
===============

Generic Vagrant Powered Development Enviroment

I've used a Box (image) from http://puppet-vagrant-boxes.puppetlabs.com/

In order to keep the repo small and light i've opted to require the user run the r10k command rather then check in all the puppet module dependenciesinto the repo. This way the developer can just update the Puppetfile and update the dependencies themselves as needed.

To install r10k on a Mac: 
>sudo gem install r10k


* Install Virtual Box
* Install Vagrant
* Checkout out This Repo
* Run:
>vagrant up



vagrant init CentOS6.4-x64 http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box
