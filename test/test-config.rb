require "yaml"

printf("testing config...")
printf("file: %s\n", File.expand_path(__FILE__))
printf("directory: %s\n", File.dirname(File.expand_path(__FILE__)))
printf("config: %s\n", File.join(__dir__, 'config.yml'))

os_config = YAML.load_file(File.join(__dir__, "openstack.yml"))
config = os_config["development"]
printf("provider: %s\n", config["provider"])

printf("rails.root: %s\n", File.join(Rails.root, 'config', 'openstack.yml'))
