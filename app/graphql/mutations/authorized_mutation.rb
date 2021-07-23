module Mutations
  class AuthorizedMutation < BaseMutation
    def current_user
      raise GraphQL::ExecutionError, "You are not authorized to perform this action" unless context[:current_user]

      context[:current_user]
    end
  end
end
