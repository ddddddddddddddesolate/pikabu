# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.sentence(word_count: 3) }
  end
end
