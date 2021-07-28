# frozen_string_literal: true

module Types
  class CommentType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :post, PostType, null: false
    field :text, String, null: false
    field :comment, CommentType, null: true
    field :comments, [CommentType], null: true
    field :replies_count, Integer, null: false
    field :likes_count, Integer, null: false
    field :dislikes_count, Integer, null: false
    field :reactions, ReactionType, null: false
    field :images, [ImageType], null: false
  end
end
