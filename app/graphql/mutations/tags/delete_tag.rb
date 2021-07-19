module Mutations
  module Tags
    class DeleteTag < BaseMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(id:)
        tag = Tag.find(id)

        tag.destroy

        { message: 'success' }
      end
    end
  end
end
