# frozen_string_literal: true

require "faker"

FactoryBot.define do
  factory :post do
    user
    title { Faker::Lorem.sentence(word_count: 4) }
    text { Faker::Lorem.sentence(word_count: 10) }
  end
end
