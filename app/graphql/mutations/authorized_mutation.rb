# frozen_string_literal: true

module Mutations
  class AuthorizedMutation < BaseMutation
    def current_user
      raise Exceptions::UnauthorizedError, "You are not authorized to perform this action" unless context[:current_user]

      context[:current_user]
    end
  end
end
