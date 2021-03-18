# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    association :dish
    association :user
  end
end
