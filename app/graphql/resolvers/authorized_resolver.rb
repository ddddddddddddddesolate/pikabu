# frozen_string_literal: true

module Resolvers
  class AuthorizedResolver < BaseResolver
    def current_user
      raise Exceptions::UnauthorizedError, "You are not authorized to perform this action" unless context[:current_user]

      context[:current_user]
    end
  end
end
