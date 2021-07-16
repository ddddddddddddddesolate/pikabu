module Mutations
  module Tags
    class CreateTag < Mutations::BaseMutation
      argument :attributes, Types::TagAttributes, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(attributes:)
        authenticate_user!

        tag = Tag.new(attributes)

        if tag.save
          { tag: tag }
        else
          { errors: tag.errors.full_messages }
        end
      end
    end
  end
end
