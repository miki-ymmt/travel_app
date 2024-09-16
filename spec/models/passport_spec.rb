require 'rails_helper'

RSpec.describe Passport, type: :model do

  let(:passport) { build(:passport) }

  describe 'アソシエーション' do
    it 'belongs to a user' do
    expect(passport.user).to be_a(User)
    end
  end
end