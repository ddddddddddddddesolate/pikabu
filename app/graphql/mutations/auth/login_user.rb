# frozen_string_literal: true

module Mutations
  module Auth
    class LoginUser < BaseMutation
      argument :credentials, Types::UserCredentialsType, required: true

      field :user, Types::UserType, null: false

      def resolve(credentials:)
        user = User.find_by(email: credentials.email)

        raise Exceptions::InvalidCredentialsError, 'Email or password is incorrect' unless user

        unless user.authenticate(credentials.password)
          raise Exceptions::InvalidCredentialsError,
                'Email or password is incorrect'
        end

        payload = { user_id: user.id }
        token = JsonWebToken.encode(payload)

        cookies[:token] = token

        { user: user }
      end
    end
  end
end
