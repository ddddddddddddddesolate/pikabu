module Mutations
  module Auth
    class RegisterUser < BaseMutation
      argument :credentials, Types::UserCredentials, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: true

      def resolve(credentials:)
        user = User.new(credentials.to_h)

        if user.save
          payload = {user_id: user.id}
          token = JsonWebToken.encode(payload)

          cookies[:token] = token

          {user: user}
        else
          {errors: user.errors.full_messages}
        end
      end
    end
  end
end
