module Mutations
  module Posts
    class DeletePost < AuthorizedMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(id:)
        post = Post.find_by(id: id)

        raise GraphQL::ExecutionError, "Post not found" unless post.present?
        raise GraphQL::ExecutionError, "You cannot delete this post" unless post.user_id == current_user.id

        post.destroy

        {message: "success"}
      end
    end
  end
end
