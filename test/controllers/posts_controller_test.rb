require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "index and show are accessible without authentication" do
    published = create_post(published_at: 1.day.ago)
    sign_out

    get posts_url
    assert_response :success

    get post_url(published)
    assert_response :success
  end

  test "write actions require authentication" do
    sign_out

    get new_post_url
    assert_redirected_to new_session_path

    assert_no_difference("Post.count") do
      post posts_url, params: { post: { title: "x", perex: "x", body: "x" } }
    end
    assert_redirected_to new_session_path

    get edit_post_url(@post)
    assert_redirected_to new_session_path

    patch post_url(@post), params: { post: { title: "x" } }
    assert_redirected_to new_session_path

    assert_no_difference("Post.count") do
      delete post_url(@post)
    end
    assert_redirected_to new_session_path
  end

  test "index lists published posts and hides drafts and future posts" do
    published = create_post(title: "Published article", perex: "Visible perex", published_at: 1.day.ago)
    draft = create_post(title: "Draft article", published_at: nil)
    scheduled = create_post(title: "Scheduled article", published_at: 1.day.from_now)

    get posts_url

    assert_response :success
    assert_select "article a[href=?]", post_path(published), text: published.title
    assert_select "a[href=?]", post_path(draft), count: 0
    assert_select "a[href=?]", post_path(scheduled), count: 0
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    assert_difference("Post.count") do
      post posts_url, params: { post: { body: @post.body, perex: @post.perex, title: @post.title } }
    end

    assert_redirected_to post_url(Post.last)
  end

  test "should show post" do
    published = create_post(published_at: 1.day.ago)
    get post_url(published)
    assert_response :success
  end

  test "show returns 404 for an unpublished draft" do
    draft = create_post(title: "Draft", published_at: nil)

    get post_url(draft)
    assert_response :not_found
  end

  test "show returns 404 for a post scheduled in the future" do
    scheduled = create_post(title: "Scheduled", published_at: 1.day.from_now)

    get post_url(scheduled)
    assert_response :not_found
  end

  test "show renders the article with title, date and body, and a link back to articles" do
    post = create_post(title: "My Article", body: "First paragraph.\n\nSecond paragraph.", published_at: Date.new(2022, 9, 5).noon)

    get post_url(post)

    assert_response :success
    assert_select "article h1", text: "My Article"
    assert_select "article time", text: "September 5, 2022"
    assert_select "article p", text: "First paragraph."
    assert_select "article p", text: "Second paragraph."
    assert_select "a[href=?][aria-label=?]", posts_path, "Go back to articles"
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { body: @post.body, perex: @post.perex, title: @post.title } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference("Post.count", -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
