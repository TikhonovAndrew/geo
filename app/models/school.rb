class School < ApplicationRecord
        extend FriendlyId
        friendly_id :name, use: :slugged
        validates :name, :about, :country_id, presence: true

        def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end

        resourcify
        has_attached_file :cover_pic, styles: { thumb: "100x100#", medium: "400x400>", large: '800x800>', slide: '1200x500#' }, default_url: "/images/school/default.png"
        validates_attachment_content_type :cover_pic, content_type: /\Aimage\/.*\Z/

        belongs_to :user
        belongs_to :country
        has_many :programs
        accepts_nested_attributes_for :programs, reject_if: :all_blank, allow_destroy: true

        self.per_page = 5

        attr_accessor :remove_cover_pic

        before_save :delete_cover_pic, if: ->{ remove_cover_pic == '1' && !cover_pic_updated_at_changed? }
  private
          def delete_cover_pic
            self.cover_pic = nil
          end

    scope :higher_education, -> { where(:category => 'higher_education') }
    scope :secondary_education, -> { where(:category => 'secondary_education') }
end
