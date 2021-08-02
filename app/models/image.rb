# frozen_string_literal: true

class Image < ApplicationRecord
  ALLOWED_TYPES = %w[Post Comment].freeze

  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader

  validates :image, presence: true, allow_blank: false
  validates :imageable_type, presence: true, inclusion: { in: ALLOWED_TYPES }
end
