module Mutations
  module Posts
    class DeletePost < Mutations::BaseMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(id:)
        raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' unless context[:current_user]

        post = context[:current_user].posts.find_by(id: id)

        raise GraphQL::ExecutionError, 'Post not found' unless post.present?

        post.destroy

        { message: 'success' }
      end
    end
  end
end
