class LineBotController < ApplicationController
  protect_from_forgery except: [:callback]  # CSRF対策無効化
  skip_before_action :require_login, only: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    client.parse_events_from(body).each do |event|
      if event.is_a?(Line::Bot::Event::Follow)
        line_user_id = event['source']['userId']
        Rails.logger.debug "Received LINE user ID: #{line_user_id}"

        user = current_user

        if user.update(line_user_id: line_user_id)
          send_success_message(event["replyToken"])
        else
          send_failure_message(event["replyToken"])
        end
      end
    end
    head :ok
  end


  def create
    line_user_id = params[:line_user_id]

    line_user = LineUser.find_by(line_user_id: line_user_id, user_id: nil) # user_idがnilでline_user_idが一致するレコードを取得

    if line_user.nil?
      Rails.logger.debug "No unlinked LINE user or LINE user already linked" # デバッグ用
      redirect_to home_path, alert: "LINEアカウントの連携に失敗しました。"
      return
    end

    # ログインしているユーザーにLINEユーザーを紐付け
    line_user.user_id = current_user.id

    if line_user.save
      Rails.logger.debug "LINE user linked successfully: #{line_user.line_user_id}" # デバッグ用
      redirect_to home_path, notice: "LINEアカウントを連携しました。"
    else
      Rails.logger.error "Failed to link LINE user with current user: #{line_user.line_user_id}" # エラーログ
      redirect_to home_path, alert: "LINEアカウントの連携に失敗しました。"
    end
  end

  def complete
    @line_user = current_user.line_user
    if @line_user.nil?
      redirect_to home_path, alert: "LINEアカウントの連携に失敗しました"
    else
      @line_user_id = @line_user.line_user_id
    end
  end
end