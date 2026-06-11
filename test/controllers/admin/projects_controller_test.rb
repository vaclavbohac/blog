require "test_helper"

class Admin::ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get admin_projects_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_project_url
    assert_response :success
  end

  test "should create project" do
    assert_difference("Project.count") do
      post admin_projects_url, params: { project: { name: "Acme", logo: "acme.svg", description: "A thing", link: "https://example.com" } }
    end

    assert_redirected_to admin_project_url(Project.last)
  end

  test "should not create project with invalid params" do
    assert_no_difference("Project.count") do
      post admin_projects_url, params: { project: { name: "", logo: "", description: "", link: "" } }
    end

    assert_response :unprocessable_content
  end

  test "should show project" do
    get admin_project_url(@project)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_project_url(@project)
    assert_response :success
  end

  test "should update project" do
    patch admin_project_url(@project), params: { project: { name: "Updated", logo: @project.logo, description: @project.description, link: @project.link } }
    assert_redirected_to admin_project_url(@project)
    assert_equal "Updated", @project.reload.name
  end

  test "should not update project with invalid params" do
    patch admin_project_url(@project), params: { project: { name: "" } }
    assert_response :unprocessable_content
  end

  test "should destroy project" do
    assert_difference("Project.count", -1) do
      delete admin_project_url(@project)
    end

    assert_redirected_to admin_projects_url
  end

  test "should require authentication" do
    sign_out

    get admin_projects_url
    assert_redirected_to new_session_url

    get new_admin_project_url
    assert_redirected_to new_session_url

    get admin_project_url(@project)
    assert_redirected_to new_session_url
  end
end
