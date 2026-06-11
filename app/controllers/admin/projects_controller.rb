class Admin::ProjectsController < Admin::BaseController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /admin/projects or /admin/projects.json
  def index
    @projects = Project.all
  end

  # GET /admin/projects/1 or /admin/projects/1.json
  def show
  end

  # GET /admin/projects/new
  def new
    @project = Project.new
  end

  # GET /admin/projects/1/edit
  def edit
  end

  # POST /admin/projects or /admin/projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to [ :admin, @project ], notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: [ :admin, @project ] }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @project.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /admin/projects/1 or /admin/projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to [ :admin, @project ], notice: "Project was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @project ] }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @project.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/projects/1 or /admin/projects/1.json
  def destroy
    @project.destroy!

    respond_to do |format|
      format.html { redirect_to admin_projects_path, notice: "Project was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      @project = Project.find(params.expect(:id))
    end

    def project_params
      params.expect(project: %i[ name logo description link ])
    end
end
