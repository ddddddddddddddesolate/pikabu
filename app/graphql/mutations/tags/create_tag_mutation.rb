# frozen_string_literal: true

module Mutations
  module Tags
    class CreateTagMutation < AuthorizedMutation
      argument :name, String, required: true

      field :tag, Types::TagType, null: false

      def resolve(name:)
        tag = TagManager::CreateTagService.call(name)

        { tag: tag }
      end
    end
  end
end
