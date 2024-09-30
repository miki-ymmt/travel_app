require 'rails_helper'

RSpec.describe Todo, type: :model do
  let(:todo) { build(:todo) }

  describe 'バリデーションチェック' do
    it 'contentが存在しているか' do
      todo.content = nil
      expect(todo).not_to be_valid
    end
  end
end
