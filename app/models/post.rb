class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  enum stroke: { free_style: 0, breast_stroke: 1, back_stroke: 2, butterfly: 3 }

  validates :title, presence: true
  validates :content, presence: true

  after_create :check_badges

  private

  def check_badges
    first_badge = Badge.find_by(name: "初投稿")
    if user.posts.count == 1 && first_badge.present?
      user.user_badges.find_or_create_by(badge: first_badge)
    end

    total_distance = user.posts.sum(:distance)
    badge_1000 = Badge.find_by(name: "1000m達成")
    if total_distance >= 1000 && badge_1000.present?
      user.user_badges.find_or_create_by(badge: badge_1000)
    end
  end
end

