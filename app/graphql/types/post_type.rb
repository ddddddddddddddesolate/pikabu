module Types
  class PostType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true
    field :comments, [CommentType], null: true

    def comments
      Comment.where(post_id: object.id, comment_id: nil)
    end
  end
end
