class PostsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_published_post, only: %i[ show ]

  # GET /posts or /posts.json
  def index
    @posts = Post.published
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  private
    # Public article lookup: only posts that have already been published are
    # reachable by URL (drafts and future posts 404).
    def set_published_post
      @post = Post.published.find(params.expect(:id))
    end
end
