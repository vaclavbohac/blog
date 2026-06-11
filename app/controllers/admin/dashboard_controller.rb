class Admin::DashboardController < Admin::BaseController
  def show
    @posts_count = Post.count
    @drafts_count = Post.where("published_at IS NULL OR published_at > ?", Time.current).count
    @series_count = Series.count
    @projects_count = Project.count
    @work_experiences_count = WorkExperience.count
    @recent_posts = Post.order(created_at: :desc).limit(5)
  end
end
