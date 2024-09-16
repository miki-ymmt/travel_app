require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe 'バリデーションチェック' do
    it '名前が存在しているか' do
      user.name = nil
      expect(user).not_to be_valid
    end

    it '名前の長さが10字以内か' do
      user.name = 'a' * 11
      expect(user).not_to be_valid
    end

    it 'emailが存在しているか' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'emailが一意か' do
      duplicate_user = user.dup
      user.save
      expect(duplicate_user).not_to be_valid
    end

    it 'validates length of password' do
      user.password = '123'
      user.password_confirmation = '123'
      expect(user).not_to be_valid
    end
  end
end
