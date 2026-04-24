class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum stroke: { free_style: 0, breast_stroke: 1, back_stroke: 2, butterfly: 3 }

  validates :title, presence: true
  validates :content, presence: true
end
