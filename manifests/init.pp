node default {
  stage { 'pre': before => Stage['main'] }
  class { 'apache':  }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  class { 'mysql': }
  class { 'mysql::server': }
  class { 'mysql::java': }
  class { 'mysql::python': }
  class { 'mysql::ruby': }
}
