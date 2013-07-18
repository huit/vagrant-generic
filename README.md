vagrant-generic
===============

Generic Vagrant Powered Development Enviroment

General notes
-------------
For the local install, we are using a box (image) from Puppet Labs (http://puppet-vagrant-boxes.puppetlabs.com/).  For the remote install, we are using the newest Amazon Linux AMI.

Puppet modules are pulled in using r10k on the VM.

Local install using VirtualBox
------------------------------
* Install VirtualBox
* Install Vagrant
* Checkout this repo
* Run:

        vagrant up --provider virtualbox

Local install using VMWare Fusion
---------------------------------
* Install VMWare Fusion
* Install Vagrant licensed for VMWare Fusion
* Checkout this repo
* Run:

        vagrant up --provider fusion

Remote install using AWS
------------------------
* Install Vagrant 1.2 or newer
* Install the Vagrant AWS plugin:
        vagrant plugin install vagrant-aws
* Create an EC2 Security Group called "vagrant"
* Create a Vagrant configuration file in your home directory to contain your AWS config values:

        cd ~/.vagrant.d/
        vim Vagrantfile
It should resemble this:
```ruby
    Vagrant.configure("2") do |config|
      config.vm.provider :aws do |aws, override|
        aws.access_key_id = "YOUR_AWS_ACCESS_KEY"
        aws.secret_access_key = "YOUR_AWS_SECRET_KEY"
        aws.keypair_name = "CHOOSE_AN_EXISTING_KEYPAIR"

        override.ssh.private_key_path = "PATH_TO_PRIVATE_KEY"
      end
    end
```
  For more options see: https://github.com/mitchellh/vagrant-aws
* Run:

        vagrant up --provider=aws
