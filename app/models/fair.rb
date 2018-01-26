class Fair < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

  has_attached_file :cover, styles: { thumb: "100x100#", medium: "400x400>", slide: '1200x400#' }, default_url: "/images/event/default.png"
  validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/
  self.per_page = 5
  attr_accessor :remove_cover

  before_save :delete_cover, if: ->{ remove_cover == '1' && !cover_updated_at_changed? }
  private
    def delete_cover
      self.cover = nil
    end

  def name_time
    "#{self.name} - #{self.fair_date_time.strftime("%m-%d-%Y")}"
  end
end
