node default {
  class { 'common': }

  class { 'mysql': }
  class { 'mysql::server': }
  class { 'mysql::java': }
  class { 'mysql::python': }
  class { 'mysql::ruby': }
  
  # These should be in a common HUIT Module I think
  package { 'git'         : ensure => present, }
  package { 'vim-enhanced': ensure => present, }
  package { 'emacs-nox'   : ensure => present, }
}
