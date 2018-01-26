class PagesController < ApplicationController
  def index
    @events = Event.where('event_date_time >= ?' , Date.today).order('event_datetime ASC').limit(6)
    @news_items = NewsItem.order('created_at DESC').limit(6)
    @testimonials = Testimonial.where('category = ?', 'Student').limit(3).order("RANDOM()")
    @fairs = Fair.where('fair_date_time >= ?', Date.today).order('fair_datetime ASC').limit(6)
  end
end
