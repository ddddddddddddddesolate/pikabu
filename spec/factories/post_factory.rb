# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :post do
    user
    title { Faker::Lorem.sentence(word_count: 4) }
    text { Faker::Lorem.sentence(word_count: 10) }
  end

  after :create do |post|
    create_list :comment, 10, post: post
  end
end
