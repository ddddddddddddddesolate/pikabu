class Post < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :tags

  has_many :comments, dependent: :delete_all
  has_many :bookmarks, as: :bookmarkable, dependent: :delete_all
  has_many :votes, as: :votable, dependent: :delete_all
  has_many :images, as: :imageable, dependent: :delete_all

  validates :title, presence: true, length: {maximum: 50}
  validates :text, length: {maximum: 255}

  scope :fresh, -> { where("posts.created_at > ?", 24.hours.ago) }
  scope :hot, -> {
    left_joins(:comments)
      .group(:id)
      .where("comments.created_at > ?", 24.hours.ago)
      .order("COUNT(comments.id) DESC")
  }
  scope :best, -> {
    left_joins(:votes)
      .group(:id)
      .where("votes.created_at > ?", 24.hours.ago)
      .order("SUM(votes.reaction) DESC")
  }
  scope :tags, ->(tag_ids) {
    joins(:tags)
      .group(:id)
      .where("tags.id IN (?)", tag_ids)
  }
  scope :likes, ->(order) {
    joins(:votes)
      .group(:id)
      .order("SUM(votes.reaction) #{order.upcase}")
  }
  scope :date, ->(order) { order(created_at: order) }
  scope :search_by, ->(field, value) { where("LOWER(#{field}) LIKE ?", "%#{value.downcase}%") }
end
