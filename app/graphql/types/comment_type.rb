# frozen_string_literal: true

module Types
  class CommentType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :text, String, null: false
    field :comment_id, ID, null: true
    field :replies_count, Integer, null: false
    field :likes_count, Integer, null: false
    field :dislikes_count, Integer, null: false
    field :reactions, [ReactionType], null: false
    field :images, [ImageType], null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
