module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :filters, Types::PostFilters, required: false
    argument :date, String, required: false
    argument :limit, Integer, required: false
    argument :offset, Integer, required: false

    def resolve(filters: nil, date: nil, limit: nil, offset: nil)
      posts = Post.all

      if filters
        posts = posts.fresh if filters.fresh
        posts = posts.hot if filters.hot
        posts = posts.best if filters.best
      end

      posts = posts.order(created_at: date) if date
      posts = posts.limit(limit) if limit
      posts = posts.offset(offset) if offset

      posts
    end
  end
end