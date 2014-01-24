node default {
  class { 'common': }
  class { 'puppetlabs_yum': }
  class { 'epel': }
  package { 'foreman-release':
    provider => 'rpm',
    source   => 'http://yum.theforeman.org/releases/1.3/el6/x86_64/foreman-release.rpm',
  }
  package { 'foreman-installer':
    require => Package['foreman-release'],
  }
}
