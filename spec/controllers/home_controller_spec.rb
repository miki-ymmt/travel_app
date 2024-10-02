# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }
  let(:trip) { create(:trip, user:) }

  before do
    login_user(user)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    context '次の旅行がある場合' do
      before do
        allow(user).to receive(:next_trip).and_return(trip)
      end

      it '次の旅行を割り当てること' do
        get :index
        expect(assigns(:next_trip)).to eq trip
      end

      it '天気情報を取得すること' do
        # controllerをスパイとして設定
        allow(controller).to receive(:fetch_or_get_cashed_weather)

        get :index

        # メソッドが正しい引数で呼び出されたことを確認
        expect(controller).to have_received(:fetch_or_get_cashed_weather).with(trip)
      end
    end

    context '次の旅行がない場合' do
      before do
        allow(user).to receive(:next_trip).and_return(nil)
      end

      it '次の旅行を割り当てないこと' do
        get :index
        expect(assigns(:next_trip)).to be_nil
      end

      it '天気情報を取得しないこと' do
        # controllerをスパイとして設定
        allow(controller).to receive(:fetch_or_get_cashed_weather)

        get :index

        # メソッドが呼び出されなかったことを確認
        expect(controller).not_to have_received(:fetch_or_get_cashed_weather).with(trip)

      end
    end
  end
end
