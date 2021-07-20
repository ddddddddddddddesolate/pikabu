module Resolvers
  class PostsResolver < BaseResolver
    type [Types::PostType], null: false

    argument :hot, Boolean, required: false

    def resolve(hot: nil)
      posts = Post.all

      posts = posts.hot if hot

      posts
    end
  end
end