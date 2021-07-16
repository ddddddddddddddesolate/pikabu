module Mutations
  module Posts
    class CreatePost < Mutations::BaseMutation
      argument :title, String, required: true
      argument :text, String, required: false

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(title: nil, text: nil)
        post = Post.new(
          title: title,
          text: text,
          user: context[:current_user]
        )

        if post.save
          { post: post }
        else
          { errors: post.errors.full_messages }
        end
      end
    end
  end
end
