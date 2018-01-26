class NewsItemsController < ApplicationController
  before_action :set_news_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :check_if_admin
  skip_before_filter :check_if_admin, only: [:index, :show]

  # GET /news_items
  # GET /news_items.json
  def index
    @news_items = NewsItem.paginate(:page => params[:page]).order('created_at DESC')
  end

  # GET /news_items/1
  # GET /news_items/1.json
  def show
  end

  # GET /news_items/new
  def new
    @news_item = NewsItem.new
  end

  # GET /news_items/1/edit
  def edit
  end

  # POST /news_items
  # POST /news_items.json
  def create
    @news_item = NewsItem.new(news_item_params)

    respond_to do |format|
      if @news_item.save
        format.html { redirect_to @news_item, notice: 'NewsItem was successfully created.' }
        format.json { render :show, status: :created, location: @news_item }
      else
        format.html { render :new }
        format.json { render json: @news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /news_items/1
  # PATCH/PUT /news_items/1.json
  def update
    respond_to do |format|
      if @news_item.update(news_item_params)
        format.html { redirect_to @news_item, notice: 'NewsItem was successfully updated.' }
        format.json { render :show, status: :ok, location: @news_item }
      else
        format.html { render :edit }
        format.json { render json: @news_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_items/1
  # DELETE /news_items/1.json
  def destroy
    @news_item.destroy
    respond_to do |format|
      format.html { redirect_to news_items_url, notice: 'NewsItem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news_item
      @news_item = NewsItem.friendly.find(params[:id])
    end

    def check_if_admin
      if signed_in?
        redirect_to :root unless current_user.has_role? :admin
      else
        return
      end
    end
    
    def news_item_params
      params.require(:news_item).permit(:title, :content, :cover, :remove_cover)
    end
end
