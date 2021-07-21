module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :filters, Types::PostsFilters, required: false
    argument :order, Types::OrderFields, required: false
    argument :paginate, Types::Pagination, required: false

    def resolve(filters: nil, order: nil, paginate: nil)
      posts = Post.all

      if filters
        posts = posts.fresh if filters.fresh
        posts = posts.hot if filters.hot
        posts = posts.best if filters.best
        posts = posts.tags(filters.tags) if filters.tags
      end

      if order
        posts = posts.likes(order.likes) if order.likes
        posts = posts.order(created_at: order.date) if order.date
      end

      if paginate
        posts = posts.limit(paginate.limit) if paginate.limit
        posts = posts.offset(paginate.offset) if paginate.offset
      end

      posts
    end
  end
end