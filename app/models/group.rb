class Group < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :group_users
  has_many :users, through: :group_users
  has_many :events, dependent: :destroy
end
