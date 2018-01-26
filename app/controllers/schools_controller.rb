class SchoolsController < ApplicationController
  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :higher_education, :secondary_education]
  before_filter :check_if_admin
  skip_before_filter :check_if_admin, only: [:index, :show]

  # GET /schools
  # GET /schools.json
  def index
    if params[:q]
      @q = School.ransack(params[:q])
      if params[:country_id].present?
        country = Country.friendly.find(params[:country_id])
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).where('country_id = ?', country).includes(:country)
      else
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).includes(:country)
      end
    else
      @q = School.ransack(params[:q])
      if params[:country_id].present?
        country = Country.friendly.find(params[:country_id])
        @schools = School.order(:name).paginate(:page => params[:page]).where('country_id = ?', country).includes(:country)
      else
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).includes(:country)
      end
    end
  end

  def higher_education
    if params[:q]
      @q = School.higher_education.ransack(params[:q])
      if params[:country_id].present?
        country = Country.friendly.find(params[:country_id])
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).where('country_id = ?', country).includes(:country)
      else
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).includes(:country)
      end
    else
      @q = School.higher_education.ransack(params[:q])
      if params[:country_id].present?
        country = Country.friendly.find(params[:country_id])
        @schools = School.higher_education.order(:name).paginate(:page => params[:page]).where('country_id = ?', country).includes(:country)
      else
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).includes(:country)
      end
    end
  end

  def secondary_education
    if params[:q]
      @q = School.secondary_education.ransack(params[:q])
      if params[:country_id].present?
        country = Country.friendly.find(params[:country_id])
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).where('country_id = ?', country).includes(:country)
      else
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).includes(:country)
      end
    else
      @q = School.secondary_education.ransack(params[:q])
      if params[:country_id].present?
        country = Country.friendly.find(params[:country_id])
        @schools = School.secondary_education.order(:name).paginate(:page => params[:page]).where('country_id = ?', country).includes(:country)
      else
        @schools = @q.result(distinct: true).order(:name).paginate(:page => params[:page]).includes(:country)
      end
    end
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
  end

  # GET /schools/new
  def new
    @school = current_user.schools.build
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = current_user.schools.build(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = School.friendly.find(params[:id])
    end

    def check_if_admin
      if signed_in?
        redirect_to :root unless current_user.has_role? :admin
      else
        return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:name, :about, :cover_pic, :remove_cover_pic, :country_id, :summary, :video, :category, :link, programs_attributes: [:id, :name, :_destroy])
    end
end
