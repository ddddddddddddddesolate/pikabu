# frozen_string_literal: true

module Mutations
  module Tags
    class DeleteTag < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        success = TagManager::DeleteTagService.call(id)

        { success: success }
      end
    end
  end
end
