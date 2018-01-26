class FairConfirmationsController < ApplicationController
  before_action :set_fair_confirmation, only: []

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
    @fair_confirmation = FairConfirmation.new
    @fair = Fair.friendly.find(params[:id])
  end

  # GET /event_confirmations/1/edit
  def edit
  end
  # POST /event_confirmations
  # POST /event_confirmations.json
  def create
    @fair_confirmation = FairConfirmation.new(fair_confirmation_params)
    if FairConfirmation.exists? email: @fair_confirmation[:email], fair_id:  @fair_confirmation[:fair_id]
      redirect_to root_path, notice: "Your have already registered for the fair. Please check your email."
      return
    end
    respond_to do |format|
      if @fair_confirmation.save
        FairMailer.confirmation_email(Fair.friendly.find(@fair_confirmation[:fair_id]), @fair_confirmation).deliver_later
        format.html { redirect_to fair_path(@fair_confirmation[:fair_id]), notice: "Successfully registered to the fair." }
        format.json { render :show, status: :created, location: @fair_confirmation }
      else
        format.html { redirect_to "#{fair_path(@fair_confirmation[:fair_id])}/register", :flash => { :error => @fair_confirmation.errors } }
        format.json { render json: @fair_confirmation.errors, status: :unprocessable_entity }
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
    def set_fair_confirmation
      @fair_confirmation = FairConfirmation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fair_confirmation_params
      params.require(:fair_confirmation).permit(:name, :surname, :email, :phone, :event_id)
    end
end
