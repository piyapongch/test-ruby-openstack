require "fog"
require "yaml"

class ObjectStoraageBase
  def initialize()
    @clint

    # load config from current directory
    os_config = YAML.load_file(File.join(__dir__, "openstack.yml"))
    config = os_config["development"]
	
  end
  
	