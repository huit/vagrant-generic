node default {
  class { 'common': }
  class { 'puppetlabs_yum': }
  class { 'foreman':
    db_type            => 'mysql',
    configure_scl_repo => false,
  }
  class { 'puppet': server => true }
}
