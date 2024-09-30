# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Trip, type: :model do
  let(:trip) { build(:trip) }

  describe 'バリデーションチェック' do
    it '目的地が存在しているか' do
      trip.destination = nil
      expect(trip).not_to be_valid
    end

    it '出発日が存在しているか' do
      trip.departure_date = nil
      expect(trip).not_to be_valid
    end

    it '帰国日が存在しているか' do
      trip.return_date = nil
      expect(trip).not_to be_valid
    end
  end
end
