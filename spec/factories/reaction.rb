# frozen_string_literal: true

FactoryBot.define do
  factory :reaction do
    user
    reaction { rand(0..1) }
    for_post

    trait :for_post do
      association :reactionable, factory: :post
    end

    trait :for_comment do
      association :reactionable, factory: :comment
    end
  end
end
