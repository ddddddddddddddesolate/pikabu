class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # parent
  belongs_to :comment, optional: true
  # replies
  has_many :comments, dependent: :delete_all
  has_many :bookmarks, as: :bookmarkable
  has_many :likes, as: :likable

  validates :text, presence: true, length: { maximum: 255 }
end
