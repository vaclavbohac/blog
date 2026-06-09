class HomepageController < ApplicationController
  def index
    @posts = Post.homepage_posts
    @work_experiences = WorkExperience.ordered
  end
end
