module Resolvers
  class PostRootCommentsResolver < BaseResolver
    type [Types::CommentType], null: false

    def resolve
      Comment.where(post_id: object.id, comment_id: nil)
    end
  end
end
