# frozen_string_literal: true

module Types
  class PostType < BaseObject
    field :id, ID, null: false
    field :user, UserType, null: false
    field :title, String, null: false
    field :text, String, null: true
    field :tags, [TagType], null: true
    field :comments, [CommentType], null: true, resolver: Resolvers::PostRootCommentsResolver
    field :comments_count, Integer, null: false
    field :likes_count, Integer, null: false
    field :dislikes_count, Integer, null: false
    field :votes, [ReactionType], null: false
    field :images, [ImageType], null: false
  end
end
