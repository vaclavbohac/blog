require "test_helper"

class SeriesTest < ActiveSupport::TestCase
  test "requires a title" do
    series = Series.new

    assert_not series.valid?
    assert_includes series.errors.attribute_names, :title
  end

  test "posts are returned in reading order by position" do
    series = Series.create!(title: "Learning Elixir")
    second = create_post(series: series, position: 2)
    first = create_post(series: series, position: 1)

    assert_equal [ first, second ], series.posts.to_a
  end

  test "destroying a series leaves its posts but unlinks them" do
    series = Series.create!(title: "Learning Elixir")
    post = create_post(series: series, position: 1)

    series.destroy

    assert Post.exists?(post.id)
    assert_nil post.reload.series_id
  end
end
