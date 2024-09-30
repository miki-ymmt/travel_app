# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TripHelper, type: :helper do
  describe '#image_url_for_trip' do
    it 'returns the url of the Los Angeles image' do
      trip = create(:trip, destination: 'ロサンゼルス')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/los_angeles.png')
    end

    it 'returns the url of the New York image' do
      trip = create(:trip, destination: 'ニューヨーク')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/new_york.png')
    end

    it 'returns the url of the Hawaii image' do
      trip = create(:trip, destination: 'ハワイ')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/hawaii.png')
    end

    it 'returns the url of the Paris image' do
      trip = create(:trip, destination: 'パリ')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/paris.png')
    end

    it 'returns the url of the London image' do
      trip = create(:trip, destination: 'ロンドン')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/london.png')
    end

    it 'returns the url of the Madrid image' do
      trip = create(:trip, destination: 'マドリード')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/madrid.png')
    end

    it 'returns the url of the Sydney image' do
      trip = create(:trip, destination: 'シドニー')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/sydney.png')
    end

    it 'returns the url of the Bangkok image' do
      trip = create(:trip, destination: 'バンコク')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/bangkok.png')
    end

    it 'returns the url of the Singapore image' do
      trip = create(:trip, destination: 'シンガポール')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/singapore.png')
    end

    it 'returns the url of the Shanghai image' do
      trip = create(:trip, destination: '上海')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/shanghai.png')
    end

    it 'returns the url of the Seoul image' do
      trip = create(:trip, destination: 'ソウル')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/seoul.png')
    end

    it 'returns the url of the Munich image' do
      trip = create(:trip, destination: 'ミュンヘン')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/munich.png')
    end

    it 'returns the url of the Kuala image' do
      trip = create(:trip, destination: 'クアラルンプール')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/kuala.png')
    end

    it 'returns the url of the Rome image' do
      trip = create(:trip, destination: 'ローマ')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/rome.png')
    end

    it 'returns the url of the Taipei image' do
      trip = create(:trip, destination: '台北')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/taipei.png')
    end

    it 'returns the url of the Ho chi minh image' do
      trip = create(:trip, destination: 'ホーチミン')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/ho_chi_minh.png')
    end

    it 'returns the url of the Hong Kong image' do
      trip = create(:trip, destination: '香港')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/hong_kong.png')
    end

    it 'returns the url of the Amsterdam image' do
      trip = create(:trip, destination: 'アムステルダム')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/amsterdam.png')
    end

    it 'returns the url of the Brussels image' do
      trip = create(:trip, destination: 'ブリュッセル')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/brussels.png')
    end

    it 'returns the url of the Other image' do
      trip = create(:trip, destination: 'その他の国')
      expect(helper.image_url_for_trip(trip)).to eq('/assets/other.png')
    end
  end
end
