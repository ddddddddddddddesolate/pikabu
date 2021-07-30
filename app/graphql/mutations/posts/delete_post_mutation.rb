# frozen_string_literal: true

module Mutations
  module Posts
    class DeletePostMutation < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        post = current_user.posts.find_by(id: id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        result = PostManager::DeletePostService.call(post)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
