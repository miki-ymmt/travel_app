require 'rails_helper'

RSpec.describe PassportsController, type: :controller do
  let(:user) { create(:user) }
  let(:passport) { create(:passport, user: user) }


  describe 'POST #create' do
    before do
        login_user(user)
    end

    context '有効な属性値の場合' do
      it 'パスポート写真を保存できること' do
        expect {
          post :create, params: { passport: attributes_for(:passport) }
        }.to change(Passport, :count).by(1)
      end
    end

    context '無効な属性値の場合' do
      it 'パスポート写真を保存できないこと' do
        expect {
          post :create, params: { passport: attributes_for(:passport, photo: nil) }
        }.not_to change(Passport, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before do
        login_user(user)
    end

    let!(:passport) { create(:passport, user: user) }

    context '有効な属性値の場合' do
      it 'パスポート写真を更新できるここと' do
        patch :update, params: { id: passport.id, passport: attributes_for(:passport) }
        expect(passport.reload.photo.file.filename).to eq Passport.last.photo.file.filename
      end

      it 'パスポートにリダイレクトすること' do
        patch :update, params: { id: passport.id, passport: attributes_for(:passport) }
        expect(response).to redirect_to(passport_path(passport))
      end
    end

    context '無効な属性値の場合' do
      it 'パスポート写真を更新できないこと' do
        patch :update, params: { id: passport.id, passport: attributes_for(:passport, photo: nil) }
        expect(passport.reload.photo).not_to eq nil
      end
    end
  end
end