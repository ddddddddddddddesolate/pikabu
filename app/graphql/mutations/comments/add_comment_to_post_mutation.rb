# frozen_string_literal: true

module Mutations
  module Comments
    class AddCommentToPostMutation < AuthorizedMutation
      argument :post_id, ID, required: true
      argument :attributes, Types::CommentAttributesType, required: true

      field :comment, Types::CommentType, null: false

      def resolve(post_id:, attributes:)
        post = Post.find_by(id: post_id)

        raise Exceptions::NotFoundError, "Post not found" unless post

        params = Hash attributes
        result = CommentManager::AddCommentToPostService.call(current_user, post, params)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { comment: result.comment }
      end
    end
  end
end
