# frozen_string_literal: true

module Mutations
  module Tags
    class DeleteTagMutation < AuthorizedMutation
      argument :id, ID, required: true

      field :success, Boolean, null: false

      def resolve(id:)
        tag = Tag.find_by(id: id)

        raise Exceptions::NotFoundError, "Tag not found" unless tag

        result = TagManager::DeleteTagService.call(tag)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { success: result.success }
      end
    end
  end
end
