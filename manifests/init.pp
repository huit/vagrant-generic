node 'vagrant.dev' {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }

  # Install and run Apache with its default configuration
  class { 'apache':
    default_vhost => true,
    keepalive     => true,
  }
}
node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }

  class {'::mongodb::globals':
    manage_package_repo => true,
  }->
  class {'::mongodb::server':
    auth    => true,
    bind_ip => [ $::ipaddress_lo, $::ipaddress_eth1 ],
  }->
  #mongodb_replset { rsmain:
  #  ensure  => present,
    #members => ['host1:27017', 'host2:27017', 'host3:27017']
  #  members => ['172.16.10.10:27017'],
  #} ->
  class {'::mongodb::client': }
  mongodb::db { 'testdb':
    user          => 'user1',
    password_hash => 'a15fbfca5e3a758be80ceaf42458bcd8',
  }
}
# vim: set ft=puppet ts=2 sw=2 ei:
