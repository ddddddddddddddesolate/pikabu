# frozen_string_literal: true

module Types
  class PostType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true
    field :comments_count, Integer, null: false
    field :likes_count, Integer, null: false
    field :dislikes_count, Integer, null: false
    field :reactions, [ReactionType], null: true
    field :images, [ImageType], null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
