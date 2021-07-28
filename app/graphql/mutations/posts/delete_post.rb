# frozen_string_literal: true

module Mutations
  module Posts
    class DeletePost < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        success = PostManager::DeletePostService.call(current_user, id)

        { success: success }
      end
    end
  end
end
