class TeamMember < ApplicationRecord
        extend FriendlyId
  friendly_id :name, use: :slugged
        has_attached_file :profile_pic, styles: { medium: "300x300#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_pic, content_type: /\Aimage\/.*\Z/

        attr_accessor :remove_profile_pic

  before_save :delete_profile_pic, if: ->{ remove_profile_pic == '1' && !profile_pic_updated_at_changed? }
  private
          def delete_profile_pic
            self.profile_pic = nil
          end

end
