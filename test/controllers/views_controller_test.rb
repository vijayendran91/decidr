require "test_helper"

class ViewsControllerTest < ActionDispatch::IntegrationTest
  test "should get person_view" do
    get views_person_view_url
    assert_response :success
  end
end
