require "test_helper"

class Admin::WorkExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_experience = work_experiences(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get admin_work_experiences_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_work_experience_url
    assert_response :success
  end

  test "should create work_experience" do
    assert_difference("WorkExperience.count") do
      post admin_work_experiences_url, params: { work_experience: { company: @work_experience.company, role: @work_experience.role, logo: @work_experience.logo, started_on: @work_experience.started_on, ended_on: @work_experience.ended_on } }
    end

    assert_redirected_to admin_work_experience_url(WorkExperience.last)
  end

  test "should show work_experience" do
    get admin_work_experience_url(@work_experience)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_work_experience_url(@work_experience)
    assert_response :success
  end

  test "should update work_experience" do
    patch admin_work_experience_url(@work_experience), params: { work_experience: { company: @work_experience.company, role: @work_experience.role, logo: @work_experience.logo, started_on: @work_experience.started_on, ended_on: @work_experience.ended_on } }
    assert_redirected_to admin_work_experience_url(@work_experience)
  end

  test "should destroy work_experience" do
    assert_difference("WorkExperience.count", -1) do
      delete admin_work_experience_url(@work_experience)
    end

    assert_redirected_to admin_work_experiences_url
  end

  test "admin actions require authentication" do
    sign_out

    get admin_work_experiences_url
    assert_redirected_to new_session_path

    get new_admin_work_experience_url
    assert_redirected_to new_session_path

    assert_no_difference("WorkExperience.count") do
      post admin_work_experiences_url, params: { work_experience: { company: "X", role: "X", logo: "x.svg", started_on: Date.current } }
    end
    assert_redirected_to new_session_path

    get admin_work_experience_url(@work_experience)
    assert_redirected_to new_session_path

    get edit_admin_work_experience_url(@work_experience)
    assert_redirected_to new_session_path

    patch admin_work_experience_url(@work_experience), params: { work_experience: { company: "X" } }
    assert_redirected_to new_session_path

    assert_no_difference("WorkExperience.count") do
      delete admin_work_experience_url(@work_experience)
    end
    assert_redirected_to new_session_path
  end
end
