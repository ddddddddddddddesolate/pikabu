module Mutations
  module Auth
    class LogoutUser < BaseMutation
      field :message, String, null: false

      def resolve
        authenticate_user!

        context[:cookies].delete(:token)
        { message: 'success' }
      end
    end
  end
end
