# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  # When running locally, use Puppet Labs CentOS image
  config.vm.box     = 'CentOS6.4-x64'
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'

  # Forward standard ports
  config.vm.network :forwarded_port, guest: 80,  host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 8443, auto_correct: true

  # When using AWS, override the box with an AMI configuration
  config.vm.provider :aws do |aws, override|
    override.vm.box     = 'huit-amazon-linux-generic'
    override.vm.box_url = 'https://raw.github.com/huit/huit-vagrant-boxes/master/aws/amazon-linux-generic.box'
  end

  # Install r10k using the shell provisioner and download the Puppet modules
  config.vm.provision :shell, :path => 'bootstrap.sh'

  # Puppet provisioner
  config.vm.provision :puppet do |puppet|
    puppet.module_path    = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options        = "--verbose --hiera_config /vagrant/hiera/hiera.yaml"
  end
end
