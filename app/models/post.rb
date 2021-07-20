class Post < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :tags

  has_many :comments, dependent: :delete_all
  has_many :bookmarks, as: :bookmarkable, dependent: :delete_all
  has_many :votes, as: :votable, dependent: :delete_all
  has_many :images, as: :imageable, dependent: :delete_all

  validates :title, presence: true, length: { maximum: 50 }
  validates :text, length: { maximum: 255 }
end
