# frozen_string_literal: true

module Resolvers
  class CommentsCountResolver < BaseResolver
    type Integer, null: false

    def resolve
      case object
      when Post
        Comment.where(post_id: object.id).count
      when Comment
        Comment.where(comment_id: object.id).count
      end
    end
  end
end
