require_relative "object_storage_client"
require "minitest/autorun"
 
class TestObjectStorageClient < Minitest::Test
 
  def test_all
    client = ObjectStorageClient.new()
    assert_instance_of(ObjectStorageClient, client)
    printf("--create service client:\n%s\n", client)
	
	client.create_container("test")
	printf("--create_container: test\n%s\n", client.list_container())
	
	printf("--list_object:\n%s\n", client.list_object("test"))
	test = client.get_container("test")
	
	client.create(test, "test.jpg", "test.jpg")
	printf("--list_object:\n%s\n", client.list_object("test"))

    obj = test.files.get("test.jpg")
	obj.metadata[:owner] = "Piyapong"
    obj.save
    obj.reload
    printf("--obj.meta-owner: %s\n", obj.metadata[:owner])
	
	obj.copy("test", "test-copy.jpg")
	printf("--list_object:\n%s\n", client.list_object("test"))
	
	obj.destroy
	obj2 = test.files.get("test-copy.jpg")
	obj2.destroy
	printf("--delete_objects:\n%s\n", client.list_object("test"))
	
	client.delete_container("test")
	printf("--delete_container: test\n%s\n", client.list_container())
  end
 
end


=begin
	client.create_container("test")
	printf("--create_container: test\n%s\n", client.list_container())
	
	test = client.get_container("test")
    	
	client.delete_container("test")
	printf("--delete_container: test\n%s\n", client.list_container())


# test client
client = ObjectStorageClient.new()
#printf("list: %s\n", client.list_container())
#client.delete_container("test2")
test = client.get_container("test")
#client.download(test, "test.jpg", "download.jpg")
file = test.files.get("test.jpg")
file.copy("test", "test-copy.jpg")

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
