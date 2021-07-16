module Mutations
  module Tags
    class DeleteTag < BaseMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(id:)
        authenticate_user!

        tag = Tag.find_by(id: id)

        raise GraphQL::ExecutionError, 'Tag not found' unless tag.present?

        tag.destroy

        { message: 'success' }
      end
    end
  end
end
