module Mutations
  module Tags
    class UpdateTag < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(id:, name:)
        raise GraphQL::ExecutionError, 'You need to authenticate to perform this action' unless context[:current_user]

        tag = Tag.find_by(id: id)

        raise GraphQL::ExecutionError, 'Tag not found' unless tag.present?

        if tag.update(name: name)
          { tag: tag }
        else
          { errors: tag.errors.full_messages }
        end

      end
    end
  end
end
