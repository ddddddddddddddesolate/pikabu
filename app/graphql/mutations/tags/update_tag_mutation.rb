# frozen_string_literal: true

module Mutations
  module Tags
    class UpdateTagMutation < AuthorizedMutation
      argument :id, ID, required: true
      argument :attributes, Types::TagAttributesType, required: true

      field :tag, Types::TagType, null: false

      def resolve(id:, attributes:)
        tag = Tag.find_by(id: id)

        raise Exceptions::NotFoundError, "Tag not found" unless tag

        params = Hash attributes
        result = TagManager::UpdateTagService.call(tag, params)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { tag: result.tag }
      end
    end
  end
end
