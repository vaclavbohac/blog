require "test_helper"

class Admin::PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get admin_posts_url
    assert_response :success
  end

  test "index lists drafts (unlike the public listing)" do
    draft = create_post(title: "A hidden draft", published_at: nil)

    get admin_posts_url

    assert_response :success
    assert_select "a[href=?]", edit_admin_post_path(draft)
  end

  test "should get new" do
    get new_admin_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post admin_posts_url, params: { post: { title: "Fresh", perex: "Fresh perex", body: "Fresh body" } }
    end

    assert_redirected_to admin_post_path(Post.last)
  end

  test "should not create an invalid post" do
    assert_no_difference("Post.count") do
      post admin_posts_url, params: { post: { title: "", perex: "", body: "" } }
    end

    assert_response :unprocessable_content
  end

  test "should get edit" do
    get edit_admin_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch admin_post_url(@post), params: { post: { title: "Renamed" } }

    assert_redirected_to admin_post_path(@post)
    assert_equal "Renamed", @post.reload.title
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete admin_post_url(@post)
    end

    assert_redirected_to admin_posts_path
  end

  test "preview renders the Markdown body to HTML" do
    post preview_admin_posts_url, params: { body: "## Hi" }

    assert_response :success
    assert_match(/<h2.*Hi<\/h2>/m, response.body)
  end

  test "admin actions require authentication" do
    sign_out

    get admin_posts_url
    assert_redirected_to new_session_path

    get new_admin_post_url
    assert_redirected_to new_session_path

    assert_no_difference("Post.count") do
      post admin_posts_url, params: { post: { title: "x", perex: "x", body: "x" } }
    end
    assert_redirected_to new_session_path

    get edit_admin_post_url(@post)
    assert_redirected_to new_session_path

    patch admin_post_url(@post), params: { post: { title: "x" } }
    assert_redirected_to new_session_path

    assert_no_difference("Post.count") do
      delete admin_post_url(@post)
    end
    assert_redirected_to new_session_path
  end
end
