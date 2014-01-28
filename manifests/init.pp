node default {
  stage { 'pre': before => Stage['main'] }
  class { 'epel': stage => 'pre' }
  class { 'common': }
  yumrepo { 'huit-splunk':
    enabled  => '1',
    gpgcheck => '0',
    baseurl  => "http://splunk4huit.s3-website-us-east-1.amazonaws.com/splunk/${::architecture}",
    descr    => "HUIT Splunk Packages for Enterprise Linux ${::os_maj_version} - ${::architecture}",
  }
}
