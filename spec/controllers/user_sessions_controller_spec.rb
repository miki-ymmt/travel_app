# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns a success response' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    let(:user) { create(:user) }

    context 'ログインに失敗した場合' do
      it 'ステータスコードが422 (Unprocessable Entity) を返すこと' do
        post :create, params: { email: 'invalid', password: 'invalid' }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'ログイン画面を再表示すること' do
        post :create, params: { email: 'invalid', password: 'invalid' }
        expect(response).to render_template(:new)
      end

      it 'エラーメッセージを表示すること' do
        post :create, params: { email: 'invalid', password: 'invalid' }
        expect(flash[:alert]).to eq(I18n.t('sessions.create.failure'))
      end
    end
  end
end
