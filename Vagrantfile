# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.require_plugin 'aws'
Vagrant.configure('2') do |config|
  # Puppet Labs CentOS 6.4 for VirtualBox
  config.vm.box     = 'puppetlabs-centos-64-x64-vbox'
  config.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box'

  # Puppet Labs CentOS 6.4 for VMWare Fusion
  config.vm.provider :fusion do |fusion, override|
    override.vm.box     = 'puppetlabs-centos-64-x64-fusion'
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-fusion503.box'
  end

  # Amazon Linux AMI
  config.vm.provider :aws do |aws, override|
    override.vm.box     = 'huit-amazon-linux-generic'
    override.vm.box_url = 'https://raw.github.com/huit/huit-vagrant-boxes/master/aws/amazon-linux-generic.box'
  end

  # Forward standard ports (local only, does not run under AWS)
  config.vm.network :forwarded_port, guest: 80,  host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 8443, auto_correct: true

  # Install r10k using the shell provisioner and download the Puppet modules
  config.vm.provision :shell, :path => 'bootstrap.sh'

  # Puppet provisioner for primary configuration
  config.vm.provision :puppet do |puppet|
    puppet.module_path    = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options        = "--verbose --hiera_config /vagrant/hiera/hiera.yaml"
  end
end
