module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true
  end
end
