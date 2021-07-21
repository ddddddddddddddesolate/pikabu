class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # parent
  belongs_to :comment, optional: true
  # replies
  has_many :comments, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :delete_all
  has_many :votes, as: :votable, dependent: :delete_all
  has_many :images, as: :imageable, dependent: :delete_all

  validates :text, presence: true, length: {maximum: 255}

  scope :likes, ->(order) {
    left_joins(:votes)
      .group(:id)
      .order("COUNT(votes.id) #{order.upcase}")
      .order("SUM(votes.reaction) #{order.upcase}")
  }
  scope :date, ->(order) { order(created_at: order) }
end
