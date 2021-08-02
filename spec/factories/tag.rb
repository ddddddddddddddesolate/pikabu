# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(number: 30) }
  end
end
