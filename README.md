vagrant-generic
===============

A generic Vagrant-powered development environment. This is a good basic starting point for spinning up a clean Vagrant image and running Puppet.  Check out the branches for specific implementations such as MediaWiki, OpenStack, and Splunk.

General notes
-------------
Vagrant 1.4+ is required for the private networking feature to work.

For the local install, we are using the [Puppet Labs](http://puppet-vagrant-boxes.puppetlabs.com/) CentOS box. For the remote install, we are using the newest Amazon Linux AMI. CentOS and Amazon Linux are reasonably similar, and are binary- and package-compatible.

We run [librarian-puppet](http://librarian-puppet.com/) to fetch Puppet modules and dependencies once the VM has booted.

Local install using VirtualBox
------------------------------
* Install [VirtualBox](http://www.virtualbox.org/manual/ch02.html)
* Install [Vagrant](http://www.vagrantup.com/downloads.html)
* Clone this repository
* From the repository base run `vagrant up`

Local install using VMWare Fusion or Workstation
------------------------------------------------
* Install VMWare Fusion or VMWare Workstation
* Install [Vagrant for VMWare](http://www.vagrantup.com/vmware)
* Clone this repository
* From the repository base run `vagrant up --provider vmware_fusion` **or** `vagrant up --provider vmware_workstation`

Remote install using AWS
------------------------
* Install [Vagrant](http://www.vagrantup.com/downloads.html)
* Install the Vagrant AWS plugin:
```
    vagrant plugin install vagrant-aws
```
* From the AWS Console or using command line tools, create a new EC2 security group called "vagrant" with, at minimum, SSH (port 22) access.
* If you do not already have one, create a new SSH keypair in EC2.
* Import our AWS Vagrant box (this is a skeleton Vagrant box that points to the proper Amazon Linux AMI):
```
    vagrant box add amazon-linux-2013.09 https://raw.github.com/huit/huit-vagrant-boxes/master/aws/amazon-linux-2013.09.box
```
* Create a Vagrant configuration file in your home directory `~/.vagrant.d/Vagrantfile` and use the below template. You must specify your AWS credentials and SSH key location, as well as your AWS region.
```ruby
    Vagrant.configure('2') do |config|
      config.vm.provider :aws do |aws, override|
        aws.access_key_id     = 'YOUR_AWS_ACCESS_KEY'
        aws.secret_access_key = 'YOUR_AWS_SECRET_KEY'
        aws.keypair_name      = 'YOUR_AWS_KEYPAIR'
        aws.region            = 'us-east-1'

        override.ssh.private_key_path = 'PATH_TO_YOUR_PRIVATE_KEY'
      end
    end
```
  For more options see: https://github.com/mitchellh/vagrant-aws
* Run: `vagrant up --provider=aws`

Extra credit
------------
Install the `vagrant-hostsupdater` plugin to keep your local `/etc/hosts` file in sync with your VM's IP address and allow you to access VMs by hostname.

Install the `vagrant-vbguest` plugin to keep the guest tools up-to-date with new versions of VirtualBox.

To speed up running `vagrant provision` pass in the environment variable `LIBRARIAN=false`, which will disable running librarian-puppet to check for and update Puppet modules. Unless you have changed the Puppetfile.lock, there is no need to run librarian additional times.
```
  LIBRARIAN=false vagrant provision
```
