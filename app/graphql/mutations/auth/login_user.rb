module Mutations
  module Auth
    class LoginUser < BaseMutation
      null true

      argument :credentials, Types::Auth::AuthProviderCredentialsInput, required: true

      field :token, String, null: true
      field :user, Types::UserType, null: true

      def resolve(credentials: nil)
        user = User.find_by!(email: credentials[:email])

        user.authenticate(credentials[:password])

        crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base.byteslice(0..31))
        token = crypt.encrypt_and_sign("user:#{user.id}")

        context[:session][:token] = token

        { user: user, token: token }
      end
    end
  end
end
