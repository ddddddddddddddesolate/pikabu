module Mutations
  module Auth
    class LogoutUser < BaseMutation
      field :message, String, null: false

      def resolve
        raise GraphQL::ExecutionError, "You are not logged in" unless cookies[:token].present?

        cookies.delete(:token)
        {message: "success"}
      end
    end
  end
end
