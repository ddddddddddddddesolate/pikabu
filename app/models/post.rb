class Post < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :tags

  has_many :comments, dependent: :destroy
  has_many :bookmarks, as: :bookmarkable
  has_many :votes, as: :votable
  has_many :images, as: :imageable

  validates :title, presence: true, length: { maximum: 50 }
  validates :text, length: { maximum: 255 }
end
