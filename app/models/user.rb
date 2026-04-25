class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :owned_groups, class_name: "Group", foreign_key: "owner_id"

  scope :search, -> (keyword) {
    if keyword.present?
      where("name LIKE ? OR email LIKE ?", "%#{keyword}%", "%#{keyword}%")
    else
      all
    end
  }
end
