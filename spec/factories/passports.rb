FactoryBot.define do
    factory :passport do
      association :user
      photo { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'assets', 'test_image.png'), 'image/png') }
    end
end