module Mutations
  class RegisterUser < BaseMutation
    class AuthProviderRegisterData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    argument :name, String, required: true
    argument :auth_provider, AuthProviderRegisterData, required: true

    type Types::UserType

    def resolve(name: nil, auth_provider: nil)
      User.create(
        name: name,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )
    end
  end
end
