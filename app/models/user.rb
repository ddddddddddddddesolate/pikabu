class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :delete_all
  has_many :comments, dependent: :delete_all
  has_many :bookmarks, dependent: :delete_all
  has_many :votes, dependent: :delete_all

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
