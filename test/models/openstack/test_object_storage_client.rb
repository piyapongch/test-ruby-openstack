require_relative "object_storage_client"
require "minitest/autorun"

class TestObjectStorageClient < Minitest::Test
  def setup()
    printf("--setup: connecting to server...\n")
    @client = ObjectStorageClient.new()
    assert_instance_of(ObjectStorageClient, @client)
    printf("--create service client:\n%s\n", @client)
  end

  def test_all()
    @client.create_container("test")
    printf("--create_container: test\n%s\n", @client.list_container())

    printf("--list_object:\n%s\n", @client.list_object("test"))

    test = @client.get_container("test")
    obj = @client.create(test, "test.jpg", "test.jpg")
    printf("--create_object:\n%s\n", @client.list_object("test"))

    printf("--download: downloading content...\n")
    @client.download(@client.get_container("test"), "test.jpg", "test-download.jpg")

    obj = test.files.get("test.jpg")
    obj.metadata[:owner] = "Piyapong"
    obj.save
    obj.reload
    printf("--obj.meta-owner: %s\n", obj.metadata[:owner])

    obj = test.files.get("test.jpg")
    obj.copy("test", "test-copy.jpg")
    printf("--list_object:\n%s\n", @client.list_object("test"))

    obj = test.files.get("test.jpg")
    obj.destroy
    obj2 = test.files.get("test-copy.jpg")
    obj2.destroy
    printf("--delete_objects:\n%s\n", @client.list_object("test"))

    @client.delete_container("test")
    printf("--delete_container: test\n%s\n", @client.list_container())
  end

  def teardown()
    printf("--tearing down...\n")
    @client.destroy
  end
end
