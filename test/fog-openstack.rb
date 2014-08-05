require "fog"

# create openstack swift service
printf("connecting to server...")
service = Fog::Storage.new({
  :provider            => "OpenStack",   # OpenStack Fog provider
  :openstack_username  => "dptester",      # Your OpenStack Username
  :openstack_api_key   => "Pb-Ds4CamLib",      # Your OpenStack Password
  :openstack_tenant    => "DPTest",
  :openstack_auth_url  => "http://129.128.119.164:5000/v2.0/tokens"
})

# create container
printf("creating test container...")
service.directories.create :key => 'test'

# get container
printf("getting test container...")
directory = service.directories.get "test"

# upload file
printf("uploading test.jpg...")
file = directory.files.create :key => "test.jpg", :body => File.open("test.jpg"), :metadata => {"file-name" => "test.jpg"}, :etag => nil

# download file
printf("downloading test.jpg...")
File.open("downloaded-file.jpg", "w") do | f |
  directory.files.get("test.jpg") do | data, remaining, content_length |
    f.syswrite data
  end
end

# print file metadata
printf("getting test.jsp object...")
file = directory.files.get("test.jpg")
printf("metadata: %s\n", file.metadata_attributes)

