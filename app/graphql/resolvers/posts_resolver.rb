module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :fresh, Boolean, required: false
    argument :hot, Boolean, required: false
    argument :best, Boolean, required: false

    def resolve(fresh: nil, hot: nil, best: nil)
      posts = Post.all

      posts = posts.fresh if fresh
      posts = posts.hot if hot
      posts = posts.best if best

      posts
    end
  end
end