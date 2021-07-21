module Mutations
  module Auth
    class LoginUser < BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: false

      def resolve(email: nil, password: nil)
        user = User.find_by(email: email)

        raise GraphQL::ExecutionError, "Invalid credentials" unless user.present?
        raise GraphQL::ExecutionError, "Invalid credentials" unless user.authenticate(password)

        payload = {user_id: user.id}
        token = JsonWebToken.encode(payload)

        context[:cookies][:token] = token

        {user: user}
      end
    end
  end
end
