module Mutations
  module Posts
    class CreatePost < Mutations::BaseMutation
      argument :attributes, Types::PostAttributes, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(attributes:)
        authenticate_user!

        post = context[:current_user].posts.new(attributes.to_h)

        if post.save
          { post: post }
        else
          { errors: post.errors.full_messages }
        end
      end
    end
  end
end
