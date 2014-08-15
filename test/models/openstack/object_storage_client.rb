require_relative "object_storage_base"
require "fog"
require "yaml"

class ObjectStorageClient < ObjectStorageBase
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
    return @service.directories.create(:key => name, :metadata => metadata)
  end

  def get_container(name)
    return @service.directories.get(name)
  end

  def list_object(name)
    container = get_container(name)
    return container.files
  end

  def delete_container(name)
    container = self.get_container(name)
    container.destroy
  end

  def create(container, name, file_path, metadata = nil)
    file = container.files.create(:key => name, :body => File.open(file_path), :etag => nil, :metadata => metadata)
    return file
  end

  def download(container, name, file_path)
    File.open(file_path, "w") do | f |
      container.files.get(name) do | data, remaining, content_length |
        f.syswrite data
      end
    end
  end

  def update(container, name, file_path, metadata = nil)
    return self.create(container, name, file_path, metadata)
  end

  def delete(container, name)
    directory = service.directories.get(container)
    file = directory.files.get(name)
    file.destroy
  end
  
  def destroy()
    #TODO: implement this method
  end

end
