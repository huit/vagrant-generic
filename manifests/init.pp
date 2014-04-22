node default {
  # Setup pre and post run stages
  # Typically these are only needed in special cases but are good to have
  stage { ['pre', 'post']: }
  Stage['pre'] -> Stage['main'] -> Stage['post']

  # Install text editors
  package { 'vim-enhanced': ensure => installed }
  package { 'emacs':        ensure => installed }

  # Declare the Harvard class for a Harvard look and feel
  class { 'harvard': }
  class { 'openstack::role::controller': }

}
# vim: set ft=puppet ts=2 sw=2 ei:
