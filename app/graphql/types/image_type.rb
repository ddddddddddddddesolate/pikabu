module Types
  class ImageType < BaseObject
    field :id, ID, null: false
    field :image, String, null: false
  end
end
