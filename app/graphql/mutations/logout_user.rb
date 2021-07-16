module Mutations
  class LogoutUser < Mutations::BaseMutation
    field :message, String, null: false

    def resolve
      raise GraphQL::ExecutionError, 'You are not logged in!' unless context[:cookies][:token].present?

      context[:cookies].delete(:token)
      { message: 'success' }
    end
  end
end
