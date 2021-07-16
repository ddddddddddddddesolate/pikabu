module Mutations
  class BaseMutation < GraphQL::Schema::Mutation
    null false

    def authenticate_user!
      return if context[:current_user]

      raise GraphQL::ExecutionError,
            "You need to authenticate to perform this action"
    end
  end
end
