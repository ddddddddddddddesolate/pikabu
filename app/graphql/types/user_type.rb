# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: true
    field :email, String, null: false
    field :posts, [PostType], null: true
    field :comments, [CommentType], null: true
    field :bookmarks, [BookmarkType], null: true
    field :reactions, [ReactionType], null: true
  end
end
