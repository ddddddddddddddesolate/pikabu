module Mutations
  module Auth
    class LoginUser < BaseMutation
      argument :credentials, Types::UserCredentials, required: true

      field :user, Types::UserType, null: false

      def resolve(credentials:)
        raise GraphQL::ExecutionError, "You already logged in" if cookies[:token].present?

        user = User.find_by(email: credentials.email)

        raise GraphQL::ExecutionError, "Email or password is incorrect" unless user.present?
        raise GraphQL::ExecutionError, "Email or password is incorrect" unless user.authenticate(credentials.password)

        payload = {user_id: user.id}
        token = JsonWebToken.encode(payload)

        cookies[:token] = token

        {user: user}
      end
    end
  end
end
