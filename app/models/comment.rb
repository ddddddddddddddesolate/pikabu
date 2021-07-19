class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  # parent
  belongs_to :comment, optional: true
  # replies
  has_many :comments, dependent: :delete_all

  validates :text, presence: true, length: { maximum: 255 }
end
