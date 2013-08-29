node default {
  stage { 'pre': before => Stage['main'] }

  class { 'apache': default_ssl_vhost => true }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  class { 'mysql': }
  class { 'mysql::server': }
  class { 'mysql::java': }
  class { 'mysql::python': }
  class { 'mysql::ruby': }
}
