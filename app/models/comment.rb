# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :comment, optional: true

  has_many :comments, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable, dependent: :delete_all
  has_many :reactions, as: :reactionable, dependent: :delete_all
  has_many :images, as: :imageable, dependent: :delete_all

  counter_culture :post, touch: true
  counter_culture :comment, column_name: 'replies_count'

  validates :text, presence: true, length: { maximum: 255 }, allow_blank: false

  scope :likes, ->(order) { order(likes_count: order) }
  scope :date, ->(order) { order(created_at: order) }
end
