module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :filters, Types::PostFilters, required: false
    argument :order, Types::OrderFields, required: false
    argument :limit, Integer, required: false
    argument :offset, Integer, required: false

    def resolve(filters: nil, order: nil, limit: nil, offset: nil)
      posts = Post.all

      if filters
        posts = posts.fresh if filters.fresh
        posts = posts.hot if filters.hot
        posts = posts.best if filters.best
      end

      if order
        posts = posts.likes(order.likes) if order.likes
        posts = posts.order(created_at: order.date) if order.date
      end

      posts = posts.limit(limit) if limit
      posts = posts.offset(offset) if offset

      posts
    end
  end
end