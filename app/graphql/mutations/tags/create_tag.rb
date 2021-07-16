module Mutations
  module Tags
    class CreateTag < Mutations::BaseMutation
      argument :name, String, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(name: nil)
        tag = Tag.new(
          name: name
        )

        if tag.save
          { tag: tag }
        else
          { errors: tag.errors.full_messages }
        end
      end
    end
  end
end
