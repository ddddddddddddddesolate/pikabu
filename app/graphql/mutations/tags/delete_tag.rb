module Mutations
  module Tags
    class DeleteTag < AuthorizedMutation
      argument :id, ID, required: true

      field :message, String, null: false

      def resolve(id:)
        tag = Tag.find_by(id: id)

        raise GraphQL::ExecutionError, "Tag not found" unless tag.present?
        raise GraphQL::ExecutionError, "You cannot delete this tag" unless tag.user_id == current_user.id

        tag.destroy

        {message: "success"}
      end
    end
  end
end
