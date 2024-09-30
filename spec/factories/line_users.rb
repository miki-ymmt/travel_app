# frozen_string_literal: true

# spec/factories/users.rb
FactoryBot.define do
  factory :line_user do
    association :user
    sequence(:line_user_id) { |n| "line_user_id_#{n}" }
  end
end
