require "test_helper"

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "index is accessible without authentication" do
    get projects_url
    assert_response :success
  end

  test "index lists the projects" do
    get projects_url

    assert_select "h1", text: /put my dent in the universe/
    assert_select "ul[role=list] > li", count: 5
  end
end
