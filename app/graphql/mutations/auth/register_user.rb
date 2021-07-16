module Mutations
  module Auth
    class RegisterUser < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true

      type Types::UserType

      def resolve(name: nil, email: nil, password: nil)
        user = User.create!(
          name: name,
          email: email,
          password: password
        )

        payload = { user_id: user.id }
        token = JsonWebToken.encode(payload)

        context[:cookies][:token] = token

        user
      end
    end
  end
end
