require 'rails_helper'

RSpec.describe LineUser, type: :model do

  let(:line_user) { build(:line_user) }

  describe 'アソシエーション' do
    it 'belongs to a user' do
      expect(line_user.user).to be_a(User)
    end
  end

  describe 'バリデーションチェック' do
    it 'line_user_idが存在しているか' do
      line_user.line_user_id = nil
      expect(line_user).not_to be_valid
    end

    it 'line_user_idが一意か' do
      create(:line_user, line_user_id: 'duplicate')
      line_user.line_user_id = 'duplicate'
      expect(line_user).not_to be_valid
    end
  end
end