class FairsController < ApplicationController
  before_action :set_fair, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :check_if_admin
  skip_before_filter :check_if_admin, only: [:index, :show]

  # GET /fairs
  # GET /fairs.json
  def index
    @fairs = Fair.where('fair_date_time >= ?', Date.today).paginate(:page => params[:page]).order('fair_date_time ASC')
        render :layout => 'application_en'
  end

  # GET /fairs/1
  # GET /fairs/1.json
  def show
  end

  # GET /fairs/new
  def new
    @fair = Fair.new
  end

  # GET /fairs/1/edit
  def edit
  end

  # POST /fairs
  # POST /fairs.json
  def create
    @fair = Fair.new(fair_params)

    respond_to do |format|
      if @fair.save
        format.html { redirect_to @fair, notice: 'Fair was successfully created.' }
        format.json { render :show, status: :created, location: @fair }
      else
        format.html { render :new }
        format.json { render json: @fair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fairs/1
  # PATCH/PUT /fairs/1.json
  def update
    respond_to do |format|
      if @fair.update(fair_params)
        format.html { redirect_to @fair, notice: 'Fair was successfully updated.' }
        format.json { render :show, status: :ok, location: @fair }
      else
        format.html { render :edit }
        format.json { render json: @fair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fairs/1
  # DELETE /fairs/1.json
  def destroy
    @fair.destroy
    respond_to do |format|
      format.html { redirect_to fairs_url, notice: 'Fair was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fair
      @fair = Fair.friendly.find(params[:id])
    end

    def check_if_admin
      if signed_in?
        redirect_to :root unless current_user.has_role? :admin
      else
        return
      end
    end
end
