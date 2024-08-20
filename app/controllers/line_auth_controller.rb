# frozen_string_literal: true

class LineAuthController < ApplicationController
  def link
    redirect_to line_login_url, allow_other_host: true # LINE認証ページにリダイレクト
  end

  # LINEから返されるコードを取得し、ユーザーのLINEアカウントを連携
  def callback
    response = get_line_token(params[:code]) # LINEログイン成功後にLINEから返されるコードを取得
    line_user_id = get_line_user_id(response) # LINEユーザーIDを取得
    Rails.logger.debug "Retrieved LINE user ID: #{line_user_id}"

    # 既存のLineUserがない場合は、新しいLineUserを作成
    if current_user.line_user.nil?
      current_user.create_line_user(line_user_id:) # 現在のユーザーにLINEアカウントを連携
      Rails.logger.debug 'Created new LineUser record'
    else
      # 既存のLineUserがある場合は、LINEユーザーIDを更新
      current_user.line_user.update(line_user_id:)
      Rails.logger.debug 'Updated existing LineUser record'
    end

    if current_user.save
      Rails.logger.debug 'Successfully linked LINE account'
      redirect_to home_path, notice: 'LINEアカウントを連携しました'
    else
      Rails.logger.error 'Failed to link LINE account'
      redirect_to home_path, alert: 'LINEアカウントの連携に失敗しました'
    end
  end

  private

  # LINE認証ページのURLを生成
  def line_login_url
    client_id = ENV['LINE_LOGIN_CHANNEL_ID']
    redirect_uri = line_auth_callback_url
    state = SecureRandom.hex(10) # CSRF対策のためのstateパラメータ
    scope = 'profile openid' # プロフィール情報を取得するためのスコープ
    bot_prompt = 'aggressive' # LINEログイン画面でのユーザーへのプロンプト表示

    "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}&bot_prompt=#{bot_prompt}"
  end

  # 認証コードを使ってアクセストークンを取得
  def get_line_token(code)
    client_id = ENV['LINE_LOGIN_CHANNEL_ID']
    client_secret = ENV['LINE_LOGIN_CHANNEL_SECRET']
    redirect_uri = line_auth_callback_url

    response = HTTParty.post('https://api.line.me/oauth2/v2.1/token', {
                               body: {
                                 grant_type: 'authorization_code',
                                 code:,
                                 redirect_uri:,
                                 client_id:,
                                 client_secret:
                               },
                               headers: { 'Content-Type' => 'application/x-www-form-urlencoded' }
                             })

    JSON.parse(response.body) # APIからのレスポンスをJSON形式に変換
  end

  # アクセストークンを使ってLINEユーザーIDを抽出
  def get_line_user_id(token_response)
    id_token = token_response['id_token']
    decoded_token = JWT.decode(id_token, nil, false).first # id_tokenをデコード
    decoded_token['sub'] # LINEユーザーIDを取得
  end
end
