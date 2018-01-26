class EventConfirmationsController < ApplicationController
  before_action :set_event_confirmation, only: []

  # GET /event_confirmations
  # GET /event_confirmations.json
  def index

  end

  # GET /event_confirmations/1
  # GET /event_confirmations/1.json
  def show
  end

  # GET /event_confirmations/new
  def new
    @event_confirmation = EventConfirmation.new
    @event = Event.friendly.find(params[:id])
  end

  # GET /event_confirmations/1/edit
  def edit
  end

  # POST /event_confirmations
  # POST /event_confirmations.json
  def create
    @event_confirmation = EventConfirmation.new(event_confirmation_params)
    if EventConfirmation.exists? email: @event_confirmation[:email], event_id:  @event_confirmation[:event_id]
      redirect_to root_path, notice: "Your have already registered for the event. Please check your email."
      return
    end
    respond_to do |format|
      if @event_confirmation.save
        EventMailer.confirmation_email(Event.friendly.find(@event_confirmation[:event_id]), @event_confirmation).deliver_later
        format.html { redirect_to event_path(@event_confirmation[:event_id]), notice: "Siz uğurla qeydiyyatdan keçdiniz." }
        format.json { render :show, status: :created, location: @event_confirmation }
      else
        format.html { redirect_to "#{event_path(@event_confirmation[:event_id])}/register", :flash => { :error => @event_confirmation.errors } }
        format.json { render json: @event_confirmation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_confirmations/1
  # PATCH/PUT /event_confirmations/1.json
  def update

  end

  # DELETE /event_confirmations/1
  # DELETE /event_confirmations/1.json
  def destroy

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_confirmation
      @event_confirmation = EventConfirmation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_confirmation_params
      params.require(:event_confirmation).permit(:name, :surname, :email, :phone, :event_id)
    end
end
