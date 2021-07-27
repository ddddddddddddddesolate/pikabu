# frozen_string_literal: true

module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :filters, Types::PostsFilters, required: false
    argument :order, Types::OrderFields, required: false
    argument :paginate, Types::Pagination, required: false
    argument :search, Types::PostsSearch, required: false

    def resolve(filters: nil, order: nil, paginate: nil, search: nil)
      posts = Post.all

      if order
        posts = posts.likes(order.likes) if order.likes
        posts = posts.date(order.date) if order.date
      end

      if filters
        posts = posts.fresh if filters.fresh
        posts = posts.best if filters.best
        posts = posts.hot if filters.hot
        posts = posts.tags(filters.tags) if filters.tags
      end

      if paginate
        posts = posts.limit(paginate.limit)
        posts = posts.offset(paginate.offset)
      end

      posts = posts.search_by('title', search.title) if search&.title

      posts
    end
  end
end
