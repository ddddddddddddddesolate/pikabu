module Resolvers
  class CommentsResolver < BaseResolver
    type [Types::CommentType], null: false

    argument :post_id, ID, required: true
    argument :order, Types::OrderFields, required: false

    def resolve(post_id:, order: nil)
      comments = Comment.where(post_id: post_id)

      if order
        comments = comments.likes(order.likes) if order.likes
        comments = comments.date(order.date) if order.date
      end

      comments
    end
  end
end