class Country < ApplicationRecord
        extend FriendlyId
        friendly_id :slug, use: :slugged
        has_attached_file :profile_pic, styles: { thumb: "100x100#", medium: "400x400>", slide: '1200x400#' }, default_url: "/images/country/default.png"
        validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/
        validates :name, :summary, :about, :visa_box, :slug, presence: true

        has_many :schools
        belongs_to :user
        attr_accessor :remove_profile_pic

        before_save :delete_profile_pic, if: ->{ remove_profile_pic == '1' && !profile_pic_updated_at_changed? }
  private
          def delete_profile_pic
            self.profile_pic = nil
          end
                scope :with_secondary_schools, -> { joins(:schools).where("schools.category = ? AND selective = ?", "secondary_education", true).distinct }
                scope :with_higher_schools, -> { joins(:schools).where("schools.category = ? AND selective = ?", "higher_education", true).distinct }
end
