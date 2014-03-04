# -*- mode: ruby -*-
# vi: set ft=ruby :

# Load AWS functionality if the plugin is installed. Networking options below
# will be ignored by the AWS plugin.
Vagrant.require_plugin 'vagrant-aws' if defined? VagrantPlugins::AWS

Vagrant.configure('2') do |config|
  # Forward standard ports (local only, does not run under AWS)
  config.vm.network :forwarded_port, guest: 80,  host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 443, host: 8443, auto_correct: true

  # By default Vagrant uses a host-only network on a private IP space that, at
  # Harvard, is reserved by the Law School. Instead, use a private IP space
  # that will never be routed (anything in the massive 172.16.0.0/12 range).
  #config.vm.network :private_network, ip: '172.16.10.10'

  # Hostname can be anything you want that does not conflict with "real" DNS
  #
  # If you install the hostsupdater plugin, you can access the VM via its
  # DNS name. To install it run: `vagrant plugin install vagrant-hostsupdater`
  config.vm.hostname = 'vagrant.dev'

  # Puppet Labs CentOS 6.5 for VirtualBox
  config.vm.provider :virtualbox do |virtualbox, override|
    override.vm.box     = 'centos-65-x64-virtualbox-puppet'
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-puppet.box'

    # Change default RAM allocation
    virtualbox.customize ['modifyvm', :id, '--memory', '512']
  end

  # Puppet Labs CentOS 6.4 for VMWare Fusion
  config.vm.provider :vmware_fusion do |fusion, override|
    override.vm.box     = 'centos-64-x64-fusion-puppet'
    override.vm.box_url = 'http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-fusion503.box'
  end

  # Amazon Linux AMI
  config.vm.provider :aws do |aws, override|
    override.vm.box       = 'amazon-linux-2013.09'
    override.vm.box_url   = 'https://raw.github.com/huit/huit-vagrant-boxes/master/aws/amazon-linux-2013.09.box'

    aws.instance_type     = 't1.micro'

    # It is good practice to tag instances with identifying information
    aws.tags = {
      'Name'        => config.vm.hostname,
      'Owner'       => ENV['USER'],
      'Provisioner' => 'vagrant-aws'
    }
  end

  # Install librarian-puppet and use it to download Puppet modules
  config.vm.provision :shell, :path => 'bootstrap.sh' unless ENV['LIBRARIAN'] == 'false'

  # Puppet provisioner for primary configuration
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "init.pp"
    puppet.options        = "--verbose --hiera_config /vagrant/hiera/hiera.yaml --modulepath /vagrant/modules"
  end

  config.vm.define "web" do |web|
    web.vm.hostname = 'vagrant.dev'
    web.vm.box = "web"
    web.vm.network :private_network, ip: '172.16.10.10'
    web.vm.network :forwarded_port, guest: 80,  host: 8080, auto_correct: true
    web.vm.network :forwarded_port, guest: 443, host: 8443, auto_correct: true
  end

  config.vm.define "mongodb1" do |mongodb1|
    mongodb1.vm.hostname = 'mongodb1.dev'
    mongodb1.vm.box = "mongodb1"
    mongodb1.vm.network :private_network, ip: '172.16.10.11'
  end

  config.vm.define "mongodb2" do |mongodb2|
    mongodb2.vm.hostname = 'mongodb2.dev'
    mongodb2.vm.box = "mongodb2"
    mongodb2.vm.network :private_network, ip: '172.16.10.12'
  end

end
