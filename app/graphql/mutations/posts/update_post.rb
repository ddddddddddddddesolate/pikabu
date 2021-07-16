module Mutations
  module Posts
    class UpdatePost < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :title, String, required: true
      argument :text, String, required: false

      field :post, Types::PostType, null: true
      field :errors, [String], null: true

      def resolve(id:, title:, text: nil)
        raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' unless context[:current_user]

        post = context[:current_user].posts.find_by(id: id)

        raise GraphQL::ExecutionError, 'Post not found' unless post.present?

        if post.update(title: title, text: text)
          { post: post }
        else
          { errors: post.errors.full_messages }
        end
      end
    end
  end
end
