module Types
  class CommentType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :post, PostType, null: false
    field :text, String, null: false
  end
end

