class Post < ApplicationRecord
  belongs_to :user

  has_and_belongs_to_many :tags

  validates :title, presence: true, length: { maximum: 50 }
  validates :text, presence: true, length: { maximum: 255 }
end
