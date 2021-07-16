module Types
  class PostType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true do
      argument :attributes, TagAttributes
    end
  end
end
