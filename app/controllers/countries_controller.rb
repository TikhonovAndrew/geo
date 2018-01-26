class CountriesController < ApplicationController
  before_action :set_country, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :check_if_admin
  skip_before_filter :check_if_admin, only: [:index, :show]

  def index
    @countries = Country.all.order("name ASC")
  end

  def show
  end

  def new
    @country = current_user.countries.build
  end

  def edit
  end

  def create
    @country = current_user.countries.build(country_params)

    respond_to do |format|
      if @country.save
        format.html { redirect_to @country, notice: 'Country was successfully created.' }
        format.json { render :show, status: :created, location: @country }
      else
        format.html { render :new }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @country.update(country_params)
        format.html { redirect_to @country, notice: 'country was successfully updated.' }
        format.json { render :show, status: :ok, location: @country }
      else
        format.html { render :edit }
        format.json { render json: @country.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @country.destroy
    respond_to do |format|
      format.html { redirect_to countries_url, notice: 'Country was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_country
      @country = Country.friendly.find(params[:id])
    end

    def check_if_admin
      if signed_in?
        redirect_to :root unless current_user.has_role? :admin
      else
        return
      end
    end

    def country_params
      params.require(:country).permit(:name, :summary, :about, :profile_pic, :remove_profile_pic, :visa_box, :slug, :video, :country_code, :selective)
    end
end
