module Mutations
  module Tags
    class CreateTag < BaseMutation
      argument :attributes, Types::TagAttributes, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(attributes:)
        tag = Tag.new(attributes.to_h)

        if tag.save
          { tag: tag }
        else
          { errors: tag.errors.full_messages }
        end
      end
    end
  end
end
