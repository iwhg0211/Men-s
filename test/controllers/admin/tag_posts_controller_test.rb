require "test_helper"

class Admin::TagPostsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get admin_tag_posts_update_url
    assert_response :success
  end
end
