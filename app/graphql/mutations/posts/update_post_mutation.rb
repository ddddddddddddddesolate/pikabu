# frozen_string_literal: true

module Mutations
  module Posts
    class UpdatePostMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :title, String, required: true
      argument :text, String, required: false

      field :post, Types::PostType, null: false

      def resolve(id:, title:, text:)
        post = PostManager::UpdatePostService.call(current_user, id, title, text)

        { post: post }
      end
    end
  end
end
