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
    default_vhost => false,
    keepalive     => true,
  }

  # In order to enable Passenger, we have to use a custom VHost, so that we can
  # pass it custom options. This is not possible with the "default" VHost, so
	# we instead make this one the default.
  apache::vhost { 'passenger.dev':
    port          => '80',
		# Passenger only works right (at least for Ruby apps) when its pointing at
		# a public directory, as per the Rails layout convention.
    docroot       => '/vagrant/webapp/public',
    default_vhost => true,
    # This is a special notation used by this module. We are passing it an
    # array of hashes, with each has containing options for a specific path.
		# In this case, we are using it to enable mod_passenger for our root
		# webapp directory.
    directories => [{
      path              => '/vagrant/webapp/public',
      passenger_enabled => 'on',
    }],
  }

  # The puppetlabs/apache module can only install Passenger from standard
  # packages, but there is no RPM for Passenger 4. Instead, we will install it
  # from RubyGems and configure it in a different way.
  $passenger_version = '4.0.37'
  # Possible languages are: ruby,python,nodejs,meteor
  $passenger_langs   = 'ruby,python'
  $passenger_prereqs = [ 'gcc-c++', 'openssl-devel', 'zlib-devel', 'apr-devel',
    'httpd-devel', 'ruby-devel', 'apr-util-devel', 'libcurl-devel' ]

	# Note that while we are installing the newest version of Passenger, we are
	# still constrained by the system version of Ruby in CentOS/RHEL, which is
	# 1.8.7 -- pretty ancient. There are ways around this, such as using RVM or
	# rbenv to install a custom-compiled version of Ruby, and then pointing
	# Passenger at it.  The Python situation is not as dire, at 2.6.6.
  package { 'passenger':
    ensure   => $passenger_version,
    provider => 'gem',
  }

  # These are Passenger prerequisites, this list is compiled from the passenger
  # installer, and saved in the $passenger_prereqs array
  package { $passenger_prereqs:
    ensure => present,
  }

  # This command compiles the Passenger Apache module if it does not already exist
  exec { 'install-passenger':
    command => "/usr/bin/passenger-install-apache2-module --auto --languages ${passenger_langs}",
    require => [ Package[$passenger_prereqs], Package['passenger'] ],
    creates => "/usr/lib/ruby/gems/1.8/gems/passenger-${passenger_version}/buildout/apache2/mod_passenger.so",
  }

  # This template file loads the Passenger module for the proper version
  file { '/etc/httpd/conf.d/passenger.conf':
    content => template('/vagrant/templates/passenger.conf.erb'),
    require => Package['httpd'],
  }
}
# vim: set ft=puppet ts=2 sw=2 ei:
