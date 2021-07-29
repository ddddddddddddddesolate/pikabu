# frozen_string_literal: true

FactoryBot.define do
  factory :bookmark do
    user
    for_post

    trait :for_post do
      association :bookmarkable, factory: :post
    end

    trait :for_comment do
      association :bookmarkable, factory: :comment
    end
  end
end
