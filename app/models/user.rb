class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :schools
  has_many :countries

  has_attached_file :avatar, styles: { thumb: "200x200#" }, default_url: "/images/user/default.png"
        validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
