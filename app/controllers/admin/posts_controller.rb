class Admin::PostsController < Admin::BaseController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /admin/posts or /admin/posts.json
  def index
    # Admins see every post — drafts and scheduled included — newest first.
    @posts = Post.order(created_at: :desc)
  end

  # GET /admin/posts/1 or /admin/posts/1.json
  def show
  end

  # GET /admin/posts/new
  def new
    @post = Post.new
  end

  # GET /admin/posts/1/edit
  def edit
  end

  # POST /admin/posts or /admin/posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to [ :admin, @post ], notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: [ :admin, @post ] }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /admin/posts/1 or /admin/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to [ :admin, @post ], notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @post ] }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @post.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/posts/1 or /admin/posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to admin_posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  # POST /admin/posts/preview
  # Renders the Markdown body to HTML for the live editor preview.
  def preview
    render html: MarkdownRenderer.render(params[:body].to_s), layout: false
  end

  private
    def set_post
      @post = Post.find(params.expect(:id))
    end

    def post_params
      params.expect(post: %i[ title body perex published_at series_id position content_path ])
    end
end
