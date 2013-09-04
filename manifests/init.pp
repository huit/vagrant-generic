node default {
  stage { 'pre': before => Stage['main'] }
  class { 'epel': stage => 'pre' }
  class { 'common': }

  class { 'mysql': }
  class { 'mysql::server': }
  class { 'mysql::java': }
  class { 'mysql::python': }
  class { 'mysql::ruby': }
  # Redis Should be it's own module
  package { 'redis': ensure=> installed, }
  class { 'hubot':
    repo_url => '',
    repo_ref => 'master',
    env_vars => { 'HUBOT_HIPCHAT_JID' => '',
                  'HUBOT_HIPCHAT_PASSWORD'   => '',
                  'HUBOT_HIPCHAT_ROOMS' => '' },
  }
}
