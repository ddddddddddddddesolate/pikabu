# frozen_string_literal: true

module Mutations
  module Posts
    class DeletePost < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        post = current_user.posts.find_by(id: id)

        raise Exceptions::NotFoundError, 'Post not found' unless post

        post.destroy

        raise Exceptions::NotDestroyedError, post.errors.full_messages.join(', ') unless post.destroyed?

        { success: true }
      end
    end
  end
end
