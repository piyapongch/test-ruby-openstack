require "fog"

# create openstack swift service
service = Fog::Storage.new({
  :provider            => "OpenStack",   # OpenStack Fog provider
  :openstack_username  => "eraadmin",      # Your OpenStack Username
  :openstack_api_key   => "r+p7vNH&T$",      # Your OpenStack Password
  :openstack_tenant    => "ERA",
  :openstack_auth_url  => "http://129.128.119.164:5000/v2.0/tokens"
})

# get container
directory = service.directories.get "test"

# upload file
file = directory.files.create :key => "test.jpg", :body => File.open("test.jpg"), :metadata => {"file-name" => "test.jpg"}, :etag => nil

# download file
File.open("downloaded-file.jpg", "w") do | f |
  directory.files.get("test.jpg") do | data, remaining, content_length |
    f.syswrite data
  end
end

# print file metadata
file = directory.files.get("test.jpg")
printf("metadata: %s\n", file.metadata_attributes)

