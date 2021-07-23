module Mutations
  module Tags
    class CreateTag < AuthorizedMutation
      argument :attributes, Types::TagAttributes, required: true

      field :tag, Types::TagType, null: true
      field :errors, [String], null: true

      def resolve(attributes:)
        tag = current_user.tags.new(attributes.to_h)

        if tag.save
          {tag: tag}
        else
          {errors: tag.errors.full_messages}
        end
      end
    end
  end
end
