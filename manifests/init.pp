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

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }

}
# vim: set ft=puppet ts=2 sw=2 ei:
