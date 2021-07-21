module Resolvers
  class CommentsCountResolver < BaseResolver
    type Integer, null: false

    def resolve
      if object.is_a?(Post)
        Comment.where(post_id: object.id).count
      elsif object.is_a?(Comment)
        Comment.where(comment_id: object.id).count
      end
    end
  end
end
