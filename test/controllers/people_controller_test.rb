require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get people_upload_url
    assert_response :success
  end
end
