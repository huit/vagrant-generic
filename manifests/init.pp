node default {
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

  class { 'apache::mod::php': }
  class { 'mysql::server': }

  package { 'php-mysql':
    ensure  => installed,
    require => Class['apache::mod::php'],
    notify  => Service['httpd'],
  }

  mysql::db { 'wordpress':
    user     => 'wordpress',
    password => 'secret',
    host     => 'localhost',
    grant    => [ 'ALL' ],
  }

  file { '/var/www/html/wp-config.php':
    ensure => present,
    owner  => 'vagrant',
    group  => 'vagrant',
    source => '/vagrant/files/wp-config.php',
  }
}
# vim: set ft=puppet ts=2 sw=2 ei:
