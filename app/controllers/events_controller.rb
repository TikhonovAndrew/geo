class EventsController < ApplicationController

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :check_if_admin
  skip_before_filter :check_if_admin, only: [:index, :show]

  def index
    @events = Event.where('event_date_time >= ?', Date.today).paginate(:page => params[:page]).order('event_date_time ASC')
  end

  def show
  end

  def new
    @event = Event.new
  end

  def edit
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.'}
	format.json { render :show, status: :created, location: @event }
      else
	format.html { render :new }
	format.json {render json: @event.errors, status: :unprocessable_entity }
      end
    end

  def update
    respond_to do |format|
      if @event.update(event_params)
	format.html { redirect_to @event, notice: 'Event was successfully updated.' }
	format.json { render :show, status: :ok, location: @event }
      else
	format.html { render :edit }
	format.json { render json: @event.errors, staus: :unproccessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_event
      @event = Event.friendly.find(params[:id])
    end

    def check_if_admin
      if signed_in?
        redirect_to :root unless current_user.has_role? :admin
      else
        return
      end
    end

    def event_params
      params.require(:event).permit(:name, :description, :price, :event_date_time, :event_date_time_end, :cover, :remove_cover, :location, :sticky)
    end
  end
end
