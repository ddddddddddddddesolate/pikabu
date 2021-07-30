# frozen_string_literal: true

module Mutations
  module Auth
    class LogoutUserMutation < AuthorizedMutation
      field :success, Boolean, null: false

      def resolve
        cookies.delete(:token)

        { success: true }
      end
    end
  end
end
