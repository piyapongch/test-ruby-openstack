require 'openstack'

printf("connecting...\n")
os = OpenStack::Connection.create({:username => "eraadmin", :api_key=>"r+p7vNH&T$", :auth_method=>"password", :auth_url => "http://129.128.119.164:5000/v2.0/", :authtenant_name =>"ERA", :service_type=>"object-store"})
s = os.servers
printf("connected to %s\n", s)


