require "test_helper"

class UploadControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get upload_home_url
    assert_response :success
  end
end
