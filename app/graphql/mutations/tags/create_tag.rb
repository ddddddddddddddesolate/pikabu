module Mutations
  module Tags
    class CreateTag < Mutations::BaseMutation
      argument :name, String, required: true

      type Types::TagType

      def resolve(name: nil)
        Tag.create(
          name: name
        )
      end
    end
  end
end
