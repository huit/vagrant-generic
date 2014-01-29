node default {
  stage { 'pre': before => Stage['main'] }

  class { 'openstack_gluster_swift': }
}
