node default {
  class { 'mrepo::params':
    source => 'git',
  }

  class { 'openstack_mirrors': }
}
