require "test_helper"

class WorkExperiencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_experience = work_experiences(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get work_experiences_url
    assert_response :success
  end

  test "index and show are accessible without authentication" do
    sign_out

    get work_experiences_url
    assert_response :success

    get work_experience_url(@work_experience)
    assert_response :success
  end

  test "write actions require authentication" do
    sign_out

    get new_work_experience_url
    assert_redirected_to new_session_path

    assert_no_difference("WorkExperience.count") do
      post work_experiences_url, params: { work_experience: { company: "X", role: "X", logo: "x.svg", started_on: Date.current } }
    end
    assert_redirected_to new_session_path

    get edit_work_experience_url(@work_experience)
    assert_redirected_to new_session_path

    patch work_experience_url(@work_experience), params: { work_experience: { company: "X" } }
    assert_redirected_to new_session_path

    assert_no_difference("WorkExperience.count") do
      delete work_experience_url(@work_experience)
    end
    assert_redirected_to new_session_path
  end

  test "should get new" do
    get new_work_experience_url
    assert_response :success
  end

  test "should create work_experience" do
    assert_difference("WorkExperience.count") do
      post work_experiences_url, params: { work_experience: { company: @work_experience.company, ended_on: @work_experience.ended_on, logo: @work_experience.logo, role: @work_experience.role, started_on: @work_experience.started_on } }
    end

    assert_redirected_to work_experience_url(WorkExperience.last)
  end

  test "should show work_experience" do
    get work_experience_url(@work_experience)
    assert_response :success
  end

  test "should get edit" do
    get edit_work_experience_url(@work_experience)
    assert_response :success
  end

  test "should update work_experience" do
    patch work_experience_url(@work_experience), params: { work_experience: { company: @work_experience.company, ended_on: @work_experience.ended_on, logo: @work_experience.logo, role: @work_experience.role, started_on: @work_experience.started_on } }
    assert_redirected_to work_experience_url(@work_experience)
  end

  test "should destroy work_experience" do
    assert_difference("WorkExperience.count", -1) do
      delete work_experience_url(@work_experience)
    end

    assert_redirected_to work_experiences_url
  end
end
