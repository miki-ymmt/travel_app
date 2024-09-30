# frozen_string_literal: true

# spec/factories/trips.rb
FactoryBot.define do
  factory :weather do
    destination { 'Tokyo' }
    temperature { 20 }
    description { '晴れ' }
    datetime { Time.current }
    fetched_at { Time.current }
  end
end
