require 'fog'
service = Fog::Storage.new({
  :provider            => 'OpenStack',   # OpenStack Fog provider
  :openstack_username  => 'eraadmin',      # Your OpenStack Username
  :openstack_api_key   => 'r+p7vNH&T$',      # Your OpenStack Password
  :openstack_auth_url  => 'http://129.128.119.164:5000/v2.0/tokens'
})
