module Mutations
  module Tags
    class UpdateTag < BaseMutation
      argument :id, ID, required: true
      argument :attributes, Types::TagAttributes, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(id:, attributes:)
        tag = Tag.find(id)

        if tag.update(attributes)
          {tag: tag}
        else
          {errors: tag.errors.full_messages}
        end
      end
    end
  end
end
