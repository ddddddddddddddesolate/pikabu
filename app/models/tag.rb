# frozen_string_literal: true

class Tag < ApplicationRecord
  has_and_belongs_to_many :posts

  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }, allow_blank: false
end
