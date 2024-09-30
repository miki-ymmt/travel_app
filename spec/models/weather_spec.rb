# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weather, type: :model do
  let(:weather) { build(:weather) }

  describe 'バリデーションチェック' do
    it 'destinationが空の時無効であること' do
      weather.destination = nil
      expect(weather).not_to be_valid
    end

    it 'trip_idが空の時無効であること' do
      weather.trip_id = nil
      expect(weather).not_to be_valid
    end

    it 'temperatureが空の時無効であること' do
      weather.temperature = nil
      expect(weather).not_to be_valid
    end

    it 'datetimeが空の時無効であること' do
      weather.datetime = nil
      expect(weather).not_to be_valid
    end

    it 'fetched_atが空の時無効であること' do
      weather.fetched_at = nil
      expect(weather).not_to be_valid
    end
  end

  describe '直近の旅行先の天気を取得する' do
    let(:trip) { create(:trip) }
    let!(:older_weather) { create(:weather, trip:, fetched_at: 2.minutes.ago) }
    let!(:newer_weather) { create(:weather, trip:, fetched_at: 1.minute.ago) }

    it '指定されたtrip_idの最新のweatherを取得できること' do
      latest_weather = described_class.where(trip:).order(fetched_at: :desc).first
      expect(latest_weather).to eq(newer_weather)
    end

    it '最新のweatherが一番新しいfetched_atを持つこと' do
      latest_weather = described_class.where(trip:).order(fetched_at: :desc).first
      expect(latest_weather.fetched_at).to be > older_weather.fetched_at
    end
  end
end
