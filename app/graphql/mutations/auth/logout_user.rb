module Mutations
  module Auth
    class LogoutUser < AuthorizedMutation
      field :success, Boolean, null: false

      def resolve
        cookies.delete(:token)

        { success: true }
      end
    end
  end
end
