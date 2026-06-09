require "test_helper"

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end

  test "renders published post cards on the homepage" do
    published = create_post(title: "Published post", perex: "A published perex", published_at: 1.day.ago)

    get root_url

    assert_response :success

    # Each homepage post is rendered as an <article> card with a linked title.
    assert_select "article", minimum: 1
    assert_select "article a[href=?]", post_path(published), text: published.title
    assert_select "article", text: /A published perex/
  end

  test "renders work history in the resume sidebar" do
    WorkExperience.create!(company: "Planetaria", role: "CEO", logo: "planetaria.svg", started_on: Date.new(2019, 1, 1), ended_on: nil)
    WorkExperience.create!(company: "Starbucks", role: "Shift Supervisor", logo: "starbucks.svg", started_on: Date.new(2008, 1, 1), ended_on: Date.new(2011, 1, 1))

    get root_url

    assert_response :success
    assert_select "dd", text: "Planetaria"
    assert_select "dd", text: "Starbucks"
    # Ongoing roles render "Present" instead of an end year.
    assert_select "time", text: "Present"
    assert_select "time", text: "2008"
  end

  test "does not render unpublished or future posts" do
    draft = create_post(title: "Draft post", perex: "Hidden draft", published_at: nil)
    scheduled = create_post(title: "Scheduled post", perex: "Hidden scheduled", published_at: 1.day.from_now)

    get root_url

    assert_response :success
    assert_select "a[href=?]", post_path(draft), count: 0
    assert_select "a[href=?]", post_path(scheduled), count: 0
  end
end
