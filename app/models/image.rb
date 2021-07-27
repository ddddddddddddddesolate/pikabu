class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true

  mount_uploader :image, ImageUploader

  validates :image, presence: true, allow_blank: false
end
