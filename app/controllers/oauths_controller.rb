# frozen_string_literal: true

class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    # 指定したプロバイダの認証ページにリダイレクト
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]

    #　既存のユーザーをプロバイダ情報を元に検索し、見つかればログイン
    if (@user = login_from(auth_params[:provider]))
      flash[:notice] = "Googleアカウントでログインしました"
      redirect_to home_path
    else
      begin

        #Googleアカウントのメールアドレスと一致する既存のユーザーがいるか検索
        sorcery_fetch_user_hash(provider)
        existing_user = User.find_by(email: @user_hash[:user_info][:email])

        if existing_user
        # 既存ユーザーにGoogleプロバイダ情報を追加
          existing_user.authentications.create(provider: provider, uid: @user_hash[:uid].to_s)
          auto_login(existing_user)
          redirect_to home_path, notice: 'Googleアカウントでログインしました'
        else
          # 新規ユーザーを作成し、Googleプロバイダ情報を追加
          sign_up_and_login_from(provider)
          redirect_to home_path, notice: 'Googleアカウントでログインしました'
        end

      rescue StandardError => e
        redirect_to login_path, alert: 'Google認証に失敗しました'
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def sign_up_and_login_from(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end
