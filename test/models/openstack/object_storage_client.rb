require "fog"
require "yaml"

class ObjectStorageClient

  def initialize()

    # load config from current directory
    os_config = YAML.load_file(File.join(__dir__, "openstack.yml"))
    config = os_config["development"]

    # create a connection
	@service = Fog::Storage.new({
      :provider            => config["provider"],
      :openstack_username  => config["username"],
      :openstack_api_key   => config["api_key"],
      :openstack_tenant    => config["tenant"],
      :openstack_auth_url  => config["auth_url"]
    })
  end
  
  def list_container()
	return @service.directories
  end
  
  def create_container(name, metadata = nil)
    @service.directories.create(:key => name, :metadata => metadata)
  end
  
  def get_container(name)
	return @service.directories.get(name)
  end
  
  def list_object(name)
    container = get_container(name)
	return container.files
  end
  
  def delete_container(name)
    directory = self.get_container(name)
	directory.destroy
  end    
  
  def create(container, name, file_path, metadata = nil)
    file = container.files.create(:key => name, :body => File.open(file_path), :etag => nil, :metadata => metadata)
  end
  
  def download(container, name, file_path)
    File.open(file_path, "w") do | f |
      container.files.get(name) do | data, remaining, content_length |
        f.syswrite data
      end
    end
  end
  
  def update(container, name, file_path, metadata = nil)
    self.create(container, name, file_path, metadata)
  end
  
  def delete(container, name)
    directory = service.directories.get(container)
	file = directory.files.get(name)
	file.destroy
  end
end

# test client
client = ObjectStorageClient.new()
#printf("list: %s\n", client.list_container())
#client.delete_container("test2")
test = client.get_container("test")
#client.download(test, "test.jpg", "download.jpg")
file = test.files.get("test.jpg")
file.copy("test", "test-copy.jpg")

=begin
metadata = {:owner => "Piyapong"}
client.create(test, "test.jpg", "test.jpg")
printf("list: %s\n", client.list_container("test"))
obj = test.files.get("test.jpg")
client.metadata(test, "test.jsp", metadata)
obj.save
obj.reload
obj.metadata[:xxx2] = "Test2"
obj.save
obj.reload
printf("obj.meta: %s\n", obj.metadata[:owner])
printf("obj.attrs: %s\n", obj.attributes)
=end