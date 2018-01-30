class PagesController < ApplicationController
  layout :resolve_layout
  before_action :authenticate_user!, only: [:event_registrations, :fair_registrations]
  before_filter :check_if_admin, only: [:event_registrations, :fair_registrations]
  def index
    @testimonials = Testimonial.where('category = ?', 'Student').limit(3).order("RANDOM()")
    @events = Event.where('event_date_time >= ?', Date.today).order('event_date_time ASC').limit(3)
    @news_items = NewsItem.order('created_at DESC').limit(3)
  end

  def about
  end

  def about_en
        render :layout => 'application_en'
  end

  def contact
  end

  def contact_en
        render :layout => 'application_en'
  end

  def partners
    @fairs = Fair.where('fair_date_time >= ?', Date.today).order('fair_date_time ASC').limit(3)
        render :layout => 'application_en'
  end

  def journals
  end

  def journals_en
        render :layout => 'application_en'
  end

  def progress
  end

  def event_registrations
    @events = Event.order('event_date_time desc')
    @event_months = @events.group_by { |e| e.event_date_time.beginning_of_month }
     if params[:event].present?
        @records = EventConfirmation.page(params[:page]).where('event_id = ?', params[:event])
                @students_count = EventConfirmation.where('event_id = ?', params[:event]).count
                @event = Event.find(params[:event])
          respond_to do |format|
          format.html
                  format.csv { render text: EventConfirmation.where('event_id = ?', params[:event]).to_csv }
              end
     else
        @records = EventConfirmation.page(params[:page]).order('event_id ASC')
     end
  end

  def fair_registrations
    @fairs = Fair.order('fair_date_time desc')
    @fair_months = @fairs.group_by { |e| e.fair_date_time.beginning_of_month }
     if params[:fair].present?
        @records = FairConfirmation.page(params[:page]).where('fair_id =?', params[:fair])
        @partners_count = FairConfirmation.where('fair_id = ?', params[:fair]).count
        @fair = Fair.find(params[:fair])
          respond_to do |format|
          format.html
          format.csv {render text: FairConfirmation.where('fair_id = ?', params[:fair]).to_csv }
          end
     else
        @records = FairConfirmation.page(params[:page]).order('fair_id ACS')
     end
  end


    private

        def check_if_admin
          if signed_in?
            redirect_to :root unless current_user.has_role? :admin
          else
            return
          end
        end

        def resolve_layout
                case action_name
                when "event_registrations"
                        "private"
                when "fair_registrations"
                        "private"
                else
                        "application"
                end
        end
end