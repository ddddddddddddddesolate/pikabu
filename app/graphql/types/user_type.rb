module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :posts, [PostType], null: true
    field :comments, [CommentType], null: true
    field :bookmarks, [BookmarkType], null: true
    field :votes, [VoteType], null: true
  end
end
