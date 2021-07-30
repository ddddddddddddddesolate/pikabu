# frozen_string_literal: true

module Types
  class UserCredentialsType < BaseInputObject
    argument :email, String, required: true
    argument :password, String, required: true
    argument :name, String, required: false
  end
end
