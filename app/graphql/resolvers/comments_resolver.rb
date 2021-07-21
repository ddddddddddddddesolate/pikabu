module Resolvers
  class CommentsResolver < BaseResolver
    type [Types::CommentType], null: false

    argument :post_id, ID, required: true

    def resolve(post_id:)
      Comment.where(post_id: post_id)
    end
  end
end