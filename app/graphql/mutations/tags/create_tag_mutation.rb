# frozen_string_literal: true

module Mutations
  module Tags
    class CreateTagMutation < AuthorizedMutation
      argument :attributes, Types::TagAttributesType, required: true

      field :tag, Types::TagType, null: false

      def resolve(attributes:)
        params = Hash attributes
        result = TagManager::CreateTagService.call(params)

        raise Exceptions::ValidationError, result.errors.join(", ") unless result.success

        { tag: result.tag }
      end
    end
  end
end
