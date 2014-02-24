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
}
# vim: set ft=puppet ts=2 sw=2 ei:
