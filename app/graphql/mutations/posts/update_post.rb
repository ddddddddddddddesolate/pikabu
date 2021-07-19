module Mutations
  module Posts
    class UpdatePost < BaseMutation
      argument :attributes, Types::PostAttributes, required: true

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(id:, attributes:)
        authenticate_user!

        post = context[:current_user].posts.find(id)

        if post.update(attributes)
          { post: post }
        else
          { errors: post.errors.full_messages }
        end
      end
    end
  end
end
