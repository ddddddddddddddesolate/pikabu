# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user

  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags

  has_many :comments, dependent: :delete_all
  has_many :bookmarks, as: :bookmarkable, dependent: :delete_all
  has_many :reactions, as: :reactionable, dependent: :delete_all
  has_many :images, as: :imageable, dependent: :delete_all

  validates :title, presence: true, length: { maximum: 50 }, allow_blank: false
  validates :text, length: { maximum: 255 }

  scope :fresh, -> { where("posts.created_at > ?", 24.hours.ago) }
  scope :hot, lambda {
    left_joins(:comments)
      .group(:id)
      .where("comments.created_at > ?", 24.hours.ago)
      .order("COUNT(comments.id) DESC")
  }
  scope :best, lambda {
    left_joins(:reactions)
      .group(:id)
      .where("reactions.created_at > ?", 24.hours.ago)
      .order("SUM(reactions.reaction) DESC")
  }
  scope :tags, lambda { |tag_ids|
    joins(:tags)
      .group(:id)
      .where(tags: { id: tag_ids })
  }
  scope :likes, ->(order) { order(likes_count: order) }
  scope :date, ->(order) { order(created_at: order) }
  scope :search, ->(value) { where("lower(title) like ?", "%#{value.downcase}%") }
end
