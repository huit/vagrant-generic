node default {
  stage { 'pre': before => Stage['main'] }

  class { 'epel': stage => 'pre' }
  class { 'common': }

  #class { 'mysql': }
  #class { 'mysql::server': }
  #class { 'mysql::java': }
  #class { 'mysql::python': }
  #class { 'mysql::ruby': }
  #class { 'apache': default_ssl_vhost => true }

# PoCVagrant (DB Instance Identifier 
# pocVagrantUser
# _long_password
# db name : mediawiki

  class { 'mediawiki':
    server_name      => $::ec2_public_hostname,
    admin_email      => 'admin@myawesomesite.com',
    db_root_user     => 'pocVagrantUser',
    db_root_password => '_long_password',
    db_server        => 'pocvagrant.cf2rixq5q6pn.us-east-1.rds.amazonaws.com',
    doc_root         => '/var/www/html',
    max_memory       => '1024'
  }
  mediawiki::instance { 'my_wiki1':
    db_name     => 'mediawiki',
    db_server   => 'pocvagrant.cf2rixq5q6pn.us-east-1.rds.amazonaws.com',
    db_user     => 'pocVagrantUser',
    db_password => '_long_password',
    port        => '80',
    ensure      => 'present'
  }
}
