# frozen_string_literal: true

module Mutations
  module PostsTags
    class AddTagsToPost < AuthorizedMutation
      argument :id, ID, required: true
      argument :tag_names, [String], required: true

      field :post, Types::PostType, null: false

      def resolve(id:, tag_names:)
        { post: PostsTagsManager::AddTagsToPostService.call(current_user, id, tag_names) }
      end
    end
  end
end
