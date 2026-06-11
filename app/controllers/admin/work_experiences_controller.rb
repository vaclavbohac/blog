class Admin::WorkExperiencesController < Admin::BaseController
  before_action :set_work_experience, only: %i[ show edit update destroy ]

  # GET /admin/work_experiences or /admin/work_experiences.json
  def index
    @work_experiences = WorkExperience.ordered
  end

  # GET /admin/work_experiences/1 or /admin/work_experiences/1.json
  def show
  end

  # GET /admin/work_experiences/new
  def new
    @work_experience = WorkExperience.new
  end

  # GET /admin/work_experiences/1/edit
  def edit
  end

  # POST /admin/work_experiences or /admin/work_experiences.json
  def create
    @work_experience = WorkExperience.new(work_experience_params)

    respond_to do |format|
      if @work_experience.save
        format.html { redirect_to [ :admin, @work_experience ], notice: "Work experience was successfully created." }
        format.json { render :show, status: :created, location: [ :admin, @work_experience ] }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @work_experience.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /admin/work_experiences/1 or /admin/work_experiences/1.json
  def update
    respond_to do |format|
      if @work_experience.update(work_experience_params)
        format.html { redirect_to [ :admin, @work_experience ], notice: "Work experience was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @work_experience ] }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @work_experience.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/work_experiences/1 or /admin/work_experiences/1.json
  def destroy
    @work_experience.destroy!

    respond_to do |format|
      format.html { redirect_to admin_work_experiences_path, notice: "Work experience was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_work_experience
      @work_experience = WorkExperience.find(params.expect(:id))
    end

    def work_experience_params
      params.expect(work_experience: %i[ company role logo started_on ended_on ])
    end
end
