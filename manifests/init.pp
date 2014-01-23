node default {
  class { 'common': }
  class { 'puppetlabs_yum': }
  class { 'foreman':
    db_type => 'mysql',
  }
  #class { 'foreman::puppetmaster': } 
}
