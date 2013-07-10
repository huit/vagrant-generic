vagrant-generic
===============

=== NOTE User Virtualbox 4.2.12 not 4.2.14 NOTE 

https://github.com/mitchellh/vagrant/issues/1850

===
Generic Vagrant Powered Development Enviroment

We've used a Box (image) from http://puppet-vagrant-boxes.puppetlabs.com/

In order to keep the repo small and light i've opted to require the user run the r10k command rather then check in all the puppet module dependenciesinto the repo. This way the developer can just update the Puppetfile and update the dependencies themselves as needed.

To install r10k on a Mac: 
>sudo gem install r10k

Install Modules:
>r10k puppetfile install

* Install Virtual Box
* Install Vagrant
* Checkout out This Repo
* Copy Vagrantfile.example -> Vagrantfile
* Run:
>vagrant up



The CentOS6.4-x64 "box" came from this URL:
 http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box

To create instances in Amazon AWS, instsall the AWS plugin by running this command:
> vagrant plugin install vagrant-aws

Then edit the Vagrantfile as needed, update the keys, userdata and secrets 
For more options see: https://github.com/mitchellh/vagrant-aws

