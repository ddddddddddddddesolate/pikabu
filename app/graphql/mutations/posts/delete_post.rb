module Mutations
  module Posts
    class DeletePost < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        post = current_user.posts.find_by(id: id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        post.destroy

        if post.destroyed?
          { success: true }
        else
          raise Exceptions::NotDestroyedError, post.errors.full_messages.join(", ")
        end
      end
    end
  end
end
