# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # parent
  belongs_to :comment, optional: true
  # replies
  has_many :comments, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :delete_all
  has_many :reactions, as: :reactionable, dependent: :delete_all
  has_many :images, as: :imageable, dependent: :delete_all

  validates :text, presence: true, length: { maximum: 255 }, allow_blank: false

  scope :likes, lambda { |order|
    left_joins(:reactions)
      .group(:id)
      .order("COUNT(reactions.id) #{order.upcase}")
      .order("SUM(reactions.reaction) #{order.upcase}")
  }
  scope :date, ->(order) { order(created_at: order) }
end
