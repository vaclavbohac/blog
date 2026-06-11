require "test_helper"

class UsesControllerTest < ActionDispatch::IntegrationTest
  test "index is accessible without authentication" do
    get uses_url
    assert_response :success
  end

  test "index lists tool sections and items" do
    get uses_url

    assert_select "h1", text: /Software I use/
    assert_select "section h2", text: "Workstation"
    assert_select "section ul[role=list] > li h3", text: /MacBook Pro/
  end
end
