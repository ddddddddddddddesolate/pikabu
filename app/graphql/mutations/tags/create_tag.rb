# frozen_string_literal: true

module Mutations
  module Tags
    class CreateTag < AuthorizedMutation
      argument :name, String, required: true

      field :tag, Types::TagType, null: false

      def resolve(name:)
        { tag: TagManager::CreateTagService.call(name) }
      end
    end
  end
end
