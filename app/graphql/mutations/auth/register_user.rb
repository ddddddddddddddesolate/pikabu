module Mutations
  module Auth
    class RegisterUser < BaseMutation
      argument :credentials, Types::UserRegisterCredentials, required: true

      type Types::UserType

      def resolve(credentials:)
        user = User.create!(credentials)

        payload = { user_id: user.id }
        token = JsonWebToken.encode(payload)

        context[:cookies][:token] = token

        user
      end
    end
  end
end
