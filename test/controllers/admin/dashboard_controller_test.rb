require "test_helper"

class Admin::DashboardControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_as users(:one)
  end

  test "should get show" do
    get admin_root_url
    assert_response :success
  end

  test "redirects to sign in when signed out" do
    sign_out
    get admin_root_url
    assert_redirected_to new_session_path
  end
end
