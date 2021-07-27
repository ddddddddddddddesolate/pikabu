module Mutations
  module Auth
    class LoginUser < BaseMutation
      argument :credentials, Types::UserCredentials, required: true

      field :user, Types::UserType, null: false

      def resolve(credentials:)
        user = User.find_by(email: credentials.email)

        raise Exceptions::InvalidCredentialsError, "Email or password is incorrect" unless user
        raise Exceptions::InvalidCredentialsError, "Email or password is incorrect" unless user.authenticate(credentials.password)

        payload = { user_email: user.email }
        token = JsonWebToken.encode(payload)

        cookies[:token] = token

        { user: user }
      end
    end
  end
end
