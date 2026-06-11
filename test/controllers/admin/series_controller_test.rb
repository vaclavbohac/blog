require "test_helper"

class Admin::SeriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @series = series(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get admin_series_index_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_series_url
    assert_response :success
  end

  test "should create series" do
    assert_difference("Series.count") do
      post admin_series_index_url, params: { series: { title: "New Series", perex: "A fresh series.", position: 3 } }
    end

    assert_redirected_to admin_series_url(Series.last)
  end

  test "should get edit" do
    get edit_admin_series_url(@series)
    assert_response :success
  end

  test "should update series" do
    patch admin_series_url(@series), params: { series: { title: "Updated title", perex: @series.perex, position: @series.position } }
    assert_redirected_to admin_series_url(@series)
  end

  test "should destroy series" do
    assert_difference("Series.count", -1) do
      delete admin_series_url(@series)
    end

    assert_redirected_to admin_series_index_url
  end

  test "should require authentication" do
    sign_out

    get new_admin_series_url
    assert_redirected_to new_session_path

    get admin_series_index_url
    assert_redirected_to new_session_path
  end
end
