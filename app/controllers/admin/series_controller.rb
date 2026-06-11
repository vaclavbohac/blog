class Admin::SeriesController < Admin::BaseController
  before_action :set_series, only: %i[ show edit update destroy ]

  # GET /admin/series or /admin/series.json
  def index
    @series = Series.ordered
  end

  # GET /admin/series/1 or /admin/series/1.json
  def show
  end

  # GET /admin/series/new
  def new
    @series = Series.new
  end

  # GET /admin/series/1/edit
  def edit
  end

  # POST /admin/series or /admin/series.json
  def create
    @series = Series.new(series_params)

    respond_to do |format|
      if @series.save
        format.html { redirect_to [ :admin, @series ], notice: "Series was successfully created." }
        format.json { render :show, status: :created, location: [ :admin, @series ] }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @series.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /admin/series/1 or /admin/series/1.json
  def update
    respond_to do |format|
      if @series.update(series_params)
        format.html { redirect_to [ :admin, @series ], notice: "Series was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [ :admin, @series ] }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @series.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/series/1 or /admin/series/1.json
  def destroy
    @series.destroy!

    respond_to do |format|
      format.html { redirect_to admin_series_index_path, notice: "Series was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    def set_series
      @series = Series.find(params.expect(:id))
    end

    def series_params
      params.expect(series: %i[ title perex position ])
    end
end
