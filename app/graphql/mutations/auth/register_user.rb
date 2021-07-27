module Mutations
  module Auth
    class RegisterUser < BaseMutation
      argument :credentials, Types::UserCredentials, required: true

      field :user, Types::UserType, null: false

      def resolve(credentials:)
        user = User.new(credentials.to_h)

        if user.save
          payload = { user_email: user.email }
          token = JsonWebToken.encode(payload)

          cookies[:token] = token

          { user: user }
        else
          raise ActiveRecord::RecordInvalid, user
        end
      rescue ActiveRecord::RecordInvalid => e
        raise Exceptions::ValidationError, e.message
      end
    end
  end
end
