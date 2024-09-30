# frozen_string_literal: true

# spec/factories/trips.rb
FactoryBot.define do
  factory :trip do
    destination { 'Tokyo' }
    departure_date { Date.tomorrow }
    return_date { Date.tomorrow + 7.days }
    notes { 'Business trip to Tokyo' }
    association :user
    after(:create) do |trip|
      create(:todo, trip:)
    end
  end
end
