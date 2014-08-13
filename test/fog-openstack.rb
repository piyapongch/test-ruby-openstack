require "fog"
require "yaml"

# load config from current directory
os_config = YAML.load_file(File.join(__dir__, "openstack.yml"))
config = os_config["development"]

# load config from rails app config directory
# os_config = File.join(Rails.root, 'config', 'openstack.yml')

# create openstack swift service
printf("connecting to server...\n")
service = Fog::Storage.new({
  :provider            => config["provider"],   # OpenStack Fog provider
  :openstack_username  => config["username"],      # Your OpenStack Username
  :openstack_api_key   => config["api_key"],      # Your OpenStack Password
  :openstack_tenant    => config["tenant"],
  :openstack_auth_url  => config["auth_url"]
})

# create container
printf("creating test container...\n")
service.directories.create(:key => 'test')

# list container
printf("containers: %s\n", service.directories)

# get container
printf("getting test container...\n")
directory = service.directories.get("test")
file = directory.files.get("test.jpg")

# list file
#printf("file_list: %s\n", directory.files)


# print file metadata
printf("getting test.jpg object...\n")
#file.metadata[:owner] = "Piyapong"
#file.save
#printf("key: %s\n", file.key)
printf("attributs: %s\n", file.attributes["X-Object-Meta-Owner"])
printf("metadata: %s\n", file.metadata[:owner])

file = directory.files.get("test.jpg")
file.metadata[:Owner] = "Piyapong"
file.save

=begin
# upload file
printf("uploading test.jpg...")
file = directory.files.create(:key => "test.jpg", :body => File.open("test.jpg"), :etag => nil, :metadata => {:owner => "Piyapong C."})
=end

=begin
# download file
printf("downloading test.jpg...\n")
File.open("downloaded-file.jpg", "w") do | f |
  directory.files.get("test.jpg") do | data, remaining, content_length |
    f.syswrite data
  end
end

printf("before set meta1: %s\n", file.metadata[:meta1])
file.metadata[:meta1] = "test-value"
file.save
file.reload
printf("meta1: %s\n", file.metadata[:meta1])
printf("content_type: %s\n", file.content_type)

# list file
printf("file_list: %s\n", directory.files)

# copy file
#file.copy("test.jpg", "test-copy.jpg")

# delete file
#copy_file = directory.files.get("test-copy.jpg")
#copy_file.destroy
=end
