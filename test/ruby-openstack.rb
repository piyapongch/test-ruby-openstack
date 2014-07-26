# ruby openstack swift object-store testing
require 'openstack'

# open connection
printf("connecting to server...\n")
os = OpenStack::Connection.create({:username => "eraadmin", :api_key=>"r+p7vNH&T$", :auth_method=>"password", :auth_url => "http://129.128.119.164:5000/v2.0/", :authtenant_name =>"ERA", :service_type=>"object-store"})

# get container
printf("getting containner...\n")
con = os.container("test")

# list object
lst = con.objects
printf("object list: %s\n", lst)
printf("test: %s\n", con.container_metadata)

test = con.object("test.jpg")
printf("test: %s\n", test.object_metadata)

# create an object
printf("creating an object...\n")
obj = con.create_object("foo", {:metadata=>{"herpy"=>"derp"}, :content_type=>"text/plain"}, File.open("test.jpg"))
printf("obj.data: %s\n", obj.data)

# update data
foo = con.object("foo")
foo.write("test")
prinf("foo: %s\n", foo.data)
