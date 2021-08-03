# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
  end
end
