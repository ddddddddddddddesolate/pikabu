# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :post_tags, dependent: :delete_all
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }, allow_blank: false
end
