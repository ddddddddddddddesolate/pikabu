module Mutations
  module Auth
    class LogoutUser < AuthorizedMutation
      field :message, String, null: false

      def resolve
        cookies.delete(:token)

        {message: "success"}
      end
    end
  end
end
