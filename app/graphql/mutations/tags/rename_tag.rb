module Mutations
  module Tags
    class RenameTag < AuthorizedMutation
      argument :id, ID, required: true
      argument :name, String, required: true

      field :tag, Types::TagType, null: false

      def resolve(id:, name:)
        { tag: TagManager::RenameTagService.call(id, name) }
      end
    end
  end
end
