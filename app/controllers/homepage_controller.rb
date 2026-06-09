class HomepageController < ApplicationController
  allow_unauthenticated_access

  def index
    @posts = Post.homepage_posts
    @work_experiences = WorkExperience.ordered
  end
end
