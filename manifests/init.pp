node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  class { 'epel': stage => 'pre' }
  class { 'puppetlabs_yum': }
  yumrepo { 'huit-splunk':
    enabled  => '1',
    gpgcheck => '0',
    baseurl  => "http://splunk4huit.s3-website-us-east-1.amazonaws.com/splunk/${::architecture}",
    descr    => "HUIT Splunk Packages for Enterprise Linux ${::os_maj_version} - ${::architecture}",
  }
  # Declare the Harvard class for a Harvard look and feel
  class { 'harvard': }

  # Install and run Apache with its default configuration
  class { 'apache':
    default_vhost => true,
    keepalive     => true,
  }
  # Install and run Splunk as an Indexer
  class { 'splunk':
    type => 'indexer',
  }
  class { 'splunk::inputs':
    input_hash =>  { 'splunktcp://50514' => {} }
  }
  splunk::ta::files { 'Splunk_TA_nix': }

}
# vim: set ft=puppet ts=2 sw=2 ei:
