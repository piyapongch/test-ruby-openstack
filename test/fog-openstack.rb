require "fog"

# create openstack swift service
printf("connecting to server...\n")
service = Fog::Storage.new({
  :provider            => "OpenStack",   # OpenStack Fog provider
  :openstack_username  => "admin",      # Your OpenStack Username
  :openstack_api_key   => "PB4di@CamLib210b",      # Your OpenStack Password
  :openstack_tenant    => "demo",
  :openstack_auth_url  => "http://129.128.119.179:5000/v2.0/tokens"
})

# create container
printf("creating test container...\n")
service.directories.create(:key => 'test')

# list container
printf("containers: %s\n", service.directories)

# get container
printf("getting test container...\n")
directory = service.directories.get("test")

# upload file
printf("uploading test.jpg...")
file = directory.files.create(:key => "test.jpg", :body => File.open("test.jpg"), :etag => nil, :metadata => {filename: "test.jpg"})

# download file
printf("downloading test.jpg...\n")
File.open("downloaded-file.jpg", "w") do | f |
  directory.files.get("test.jpg") do | data, remaining, content_length |
    f.syswrite data
  end
end

# print file metadata
printf("getting test.jsp object...\n")
file = directory.files.get("test.jpg")
printf("key: %s\n", file.key)
printf("metadata: %s\n", file.metadata[:filename])

printf("before set meta1: %s\n", file.metadata[:meta1])
file.metadata[:meta1] = "test-value"
file.save
file.reload
printf("meta1: %s\n", file.metadata[:meta1])
printf("content_type: %s\n", file.content_type)

# copy file
file.copy("test.jpg", "test-copy.jpg")

