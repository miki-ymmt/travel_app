# frozen_string_literal: true

class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    # 指定したプロバイダの認証ページにリダイレクト
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    # 既存のユーザーをプロバイダ情報を元に検索し、存在すればログイン
    if (@user = login_from(auth_params[:provider]))
      flash[:notice] = "#{provider.titleize}アカウントでログインしました"
      redirect_to home_path
    else
      begin
        # ユーザーが存在しない場合はプロバイダ情報を元に新規ユーザーを作成し、ログイン
        signup_and_login(provider)
        flash[:notice] = "#{provider.titleize}アカウントでログインしました"
        redirect_to home_path
      rescue StandardError
        flash[:alert] = "#{provider.titleize}アカウントでのログインに失敗しました"
        redirect_to login_path
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end

  def signup_and_login(provider)
    @user = create_from(provider)
    reset_session
    auto_login(@user)
  end
end