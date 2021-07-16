module Mutations
  module Tags
    class UpdateTag < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :attributes, Types::TagAttributes, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(id:, attributes:)
        authenticate_user!

        tag = Tag.find_by(id: id)

        raise GraphQL::ExecutionError, 'Tag not found' unless tag.present?

        if tag.update(attributes)
          { tag: tag }
        else
          { errors: tag.errors.full_messages }
        end

      end
    end
  end
end
