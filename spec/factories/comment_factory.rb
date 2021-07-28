# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :comment do
    user
    post
    text { Faker::Lorem.sentence(word_count: 10) }
  end
end
