class TestimonialsController < ApplicationController
  before_action :set_testimonial, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :check_if_admin
  skip_before_filter :check_if_admin, only: [:index, :show]

  # GET /testimonials
  # GET /testimonials.json
  def index
    @testimonials = Testimonial.where('category = ?', 'Student')
  end

  # GET /testimonials/1
  # GET /testimonials/1.json
  def show
  end

  # GET /testimonials/new
  def new
    @testimonial = Testimonial.new
  end

  # GET /testimonials/1/edit
  def edit
  end

  # POST /testimonials
  # POST /testimonials.json
  def create
    @testimonial = Testimonial.new(testimonial_params)

    respond_to do |format|
      if @testimonial.save
        format.html { redirect_to @testimonial, notice: 'Testimonial was successfully created.' }
        format.json { render :show, status: :created, location: @testimonial }
      else
        format.html { render :new }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testimonials/1
  # PATCH/PUT /testimonials/1.json
  def update
    respond_to do |format|
      if @testimonial.update(testimonial_params)
        format.html { redirect_to @testimonial, notice: 'Testimonial was successfully updated.' }
        format.json { render :show, status: :ok, location: @testimonial }
      else
        format.html { render :edit }
        format.json { render json: @testimonial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testimonials/1
  # DELETE /testimonials/1.json
  def destroy
    @testimonial.destroy
    respond_to do |format|
      format.html { redirect_to testimonials_url, notice: 'Testimonial was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testimonial
      @testimonial = Testimonial.find(params[:id])
    end

    def check_if_admin
      if signed_in?
        redirect_to :root unless current_user.has_role? :admin
      else
        return
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def testimonial_params
      params.require(:testimonial).permit(:name, :body, :school, :profile_pic, :remove_profile_pic, :category)
    end
end
