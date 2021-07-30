# frozen_string_literal: true

module Resolvers
  class CommentsResolver < BaseResolver
    type [Types::CommentType], null: false

    argument :post_id, ID, required: true
    argument :order, Types::OrderFieldsType, required: false
    argument :paginate, Types::PaginationType, required: false

    def resolve(post_id:, order: nil, paginate: nil)
      comments = Comment.includes(:user, :images, reactions: [:user]).where(post_id: post_id)

      if order
        comments = comments.likes(order.likes) if order.likes
        comments = comments.date(order.date) if order.date
      end

      if paginate
        comments = comments.limit(paginate.limit)
        comments = comments.offset(paginate.offset)
      end

      comments
    end
  end
end
