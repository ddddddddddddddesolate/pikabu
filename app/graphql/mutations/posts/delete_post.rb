# frozen_string_literal: true

module Mutations
  module Posts
    class DeletePost < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        PostManager::DeletePostService.call(current_user, id)
      end
    end
  end
end
