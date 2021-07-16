module Types
  class TagType < BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :posts, [PostType], null: true
  end
end
