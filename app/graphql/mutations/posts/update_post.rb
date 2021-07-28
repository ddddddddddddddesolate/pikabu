# frozen_string_literal: true

module Mutations
  module Posts
    class UpdatePost < AuthorizedMutation
      argument :id, ID, required: true
      argument :attributes, Types::PostAttributes, required: true

      field :post, Types::PostType, null: false

      def resolve(id:, attributes:)
        post = PostManager::UpdatePostService.call(current_user, id, attributes)

        { post: post }
      end
    end
  end
end
