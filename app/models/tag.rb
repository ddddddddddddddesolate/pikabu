class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: {maximum: 30}
end
