# frozen_string_literal: true

module Mutations
  module PostsTags
    class RemoveTagsFromPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :tag_ids, [ID], required: true

      field :post, Types::PostType, null: false

      def resolve(id:, tag_ids:)
        post = PostsTagsManager::RemoveTagsFromPostService.call(current_user, id, tag_ids)

        { post: post }
      end
    end
  end
end
