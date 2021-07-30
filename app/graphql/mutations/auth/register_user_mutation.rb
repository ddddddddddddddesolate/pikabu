# frozen_string_literal: true

module Mutations
  module Auth
    class RegisterUserMutation < BaseMutation
      argument :credentials, Types::UserCredentialsType, required: true

      field :user, Types::UserType, null: false

      def resolve(credentials:)
        user = User.new(credentials.to_h)

        raise ActiveRecord::RecordInvalid unless user.save

        payload = { user_id: user.id }
        token = JsonWebToken.encode(payload)

        cookies[:token] = token

        { user: user }
      rescue ActiveRecord::RecordInvalid => e
        raise Exceptions::ValidationError, e.message
      end
    end
  end
end
