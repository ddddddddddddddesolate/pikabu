class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :bookmarks, dependent: :delete_all
  has_many :reactions, dependent: :delete_all

  validates :name, allow_blank: true, length: {maximum: 100}
  validates :email, presence: true, uniqueness: true
end
