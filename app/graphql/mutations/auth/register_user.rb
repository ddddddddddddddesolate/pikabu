module Mutations
  module Auth
    class RegisterUser < BaseMutation
      argument :credentials, Types::UserRegisterCredentials, required: true

      field :user, Types::UserType, null: false

      def resolve(credentials:)
        user = User.create!(credentials.to_h)

        payload = {user_id: user.id}
        token = JsonWebToken.encode(payload)

        context[:cookies][:token] = token

        {user: user}
      end
    end
  end
end
