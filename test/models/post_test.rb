require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "homepage_posts includes published posts ordered by published_at descending" do
    older = create_post(title: "Older", published_at: 2.days.ago)
    newer = create_post(title: "Newer", published_at: 1.hour.ago)

    assert_equal [ newer, older ], Post.homepage_posts.to_a
  end

  test "homepage_posts excludes posts without a published_at" do
    create_post(title: "Draft", published_at: nil)

    assert_empty Post.homepage_posts
  end

  test "homepage_posts excludes posts scheduled for the future" do
    create_post(title: "Scheduled", published_at: 1.day.from_now)

    assert_empty Post.homepage_posts
  end

  test "is valid with the required attributes" do
    assert build_post.valid?
  end

  test "requires title, perex and body" do
    post = Post.new

    assert_not post.valid?
    assert_includes post.errors.attribute_names, :title
    assert_includes post.errors.attribute_names, :perex
    assert_includes post.errors.attribute_names, :body
  end

  test "is valid without a published_at (draft)" do
    assert build_post(published_at: nil).valid?
  end

  test "published? is true only when published_at is in the past" do
    assert build_post(published_at: 1.hour.ago).published?
    assert_not build_post(published_at: 1.day.from_now).published?
    assert_not build_post(published_at: nil).published?
  end
end
