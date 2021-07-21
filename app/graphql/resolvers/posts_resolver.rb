module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :fresh, Boolean, required: false
    argument :hot, Boolean, required: false
    argument :best, Boolean, required: false
    argument :date, String, required: false
    argument :limit, Integer, required: false
    argument :offset, Integer, required: false

    def resolve(fresh: nil, hot: nil, best: nil, date: nil, limit: nil, offset: nil)
      posts = Post.all

      posts = posts.fresh if fresh
      posts = posts.hot if hot
      posts = posts.best if best
      posts = posts.order(created_at: date) if date
      posts = posts.limit(limit) if limit
      posts = posts.offset(offset) if offset

      posts
    end
  end
end