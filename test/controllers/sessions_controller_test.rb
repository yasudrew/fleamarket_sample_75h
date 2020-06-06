require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get logout_page" do
    get sessions_logout_page_url
    assert_response :success
  end
end
