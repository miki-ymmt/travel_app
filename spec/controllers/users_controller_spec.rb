# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #new' do
    it 'ユーザー登録画面を表示すること' do
      get :new
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    before do
      login_user user
    end

    it 'ユーザー情報を表示すること' do
      get :show, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context '有効な属性値のとき' do
      it 'ユーザーを登録できること' do
        expect do
          post :create, params: { user: attributes_for(:user) }
        end.to change(User, :count).by(1)
      end
    end

    it 'ユーザー登録画面を再表示すること' do
      post :create, params: { user: attributes_for(:user, name: nil) }
      expect(response).to render_template(:new)
    end
  end

  context '無効な属性値のとき' do
    it 'ユーザーを登録できないこと' do
      expect do
        post :create, params: { user: attributes_for(:user, name: nil) }
      end.not_to change(User, :count)
    end

    it 'ユーザー登録画面を再表示すること' do
      post :create, params: { user: attributes_for(:user, name: nil) }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'GET #edit' do
    before do
      login_user user
    end

    it 'ユーザー情報を編集すること' do
      get :edit, params: { id: user.id }
      expect(response).to be_successful
    end
  end

  describe 'PATCH #update' do
    before do
      login_user user
    end

    context '有効な属性値のとき' do
      it 'ユーザー情報を更新できること' do
        patch :update, params: { id: user.id, user: attributes_for(:user, name: 'Updated') }
        expect(user.reload.name).to eq 'Updated'
      end
    end

    context '無効な属性値のとき' do
      it 'ユーザー情報を更新できないこと' do
        patch :update, params: { id: user.id, user: attributes_for(:user, name: nil) }
        expect(user.reload.name).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login_user user
    end

    it 'ユーザーを削除できること' do
      expect do
        delete :destroy, params: { id: user.id }
      end.to change(User, :count).by(-1)
    end
  end
end
