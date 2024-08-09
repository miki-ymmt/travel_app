class LineAuthController < ApplicationController
  def link
    redirect_to line_login_url
  end

  def callback #LINEから返されるコードを取得し、ユーザーのLINEアカウントを連携
    response = get_line_token(params[:code]) #LINEログイン成功後にLINEから返されるコードを取得
    line_user_id = get_line_user_id(response) #LINEユーザーIDを取得


    if current_user.update(line_user_id: line_user_id) #現在のユーザーにLINEアカウントを連携
      redirect_to home_path, notice: "LINEアカウントを連携しました。"
    else
      redirect_to home_path, alert: "LINEアカウントの連携に失敗しました。"
    end
  end


  private

  def line_login_url #LINE認証ページのURLを生成
    client_id = ENV['LINE_LOGIN_CHANNEL_ID']
    redirect_uri = callback_line_auth_url
    state = SecureRandom.hex(10) #CSRF対策のためのstateパラメータ
    scope = "profile openid" #プロフィール情報を取得するためのスコープ

    "https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=#{client_id}&redirect_uri=#{redirect_uri}&state=#{state}&scope=#{scope}"
  end


  def get_line_token(code) #認証コードを使ってアクセストークンを取得
    client_id = ENV['LINE_LOGIN_CHANNEL_ID']
    client_secret = ENV['LINE_LOGIN_CHANNEL_SECRET']
    redirect_uri = callback_line_auth_url

    response = RestClient.post("https://api.line.me/oauth2/v2.1/token", {
      "grant_type" => "authorization_code",
      "code" => code,
      "redirect_uri" => redirect_uri,
      "client_id" => client_id,
      "client_secret" => client_secret
    })

    JSON.parse(response.body) #APIからのレスポンスをJSON形式に変換
  end

  def get_line_user_id(token_response) #アクセストークンを使ってLINEユーザーIDを抽出
    id_token = token_response["id_token"]
    decoded_token = JWT.decode(id_token, nil, false).first #id_tokenをデコード
    decoded_token["sub"] #LINEユーザーIDを取得
  end
end
