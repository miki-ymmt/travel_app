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
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      if event.is_a?(Line::Bot::Event::Follow) || event.is_a?(Line::Bot::Event::Message)
        line_user_id = event['source']['userId']
        Rails.logger.debug "Received LINE user ID: #{line_user_id}" # デバッグ用
        session[:line_user_id] = line_user_id
        Rails.logger.debug "Stored LINE user ID in session: #{session[:line_user_id]}" # デバッグ用
      end
    end
    head :ok
  end

  def create
    Rails.logger.debug "Session LINE user ID at the beginning of create action: #{session[:line_user_id]}" # デバッグ用
    line_user_id = params[:line_user_id]
    if session[:line_user_id].present? && session[:line_user_id] == line_user_id # セッションにLINEユーザーIDが存在するか確認
      line_user = LineUser.new(user_id: current_user.id, line_user_id: line_user_id) # user_idとline_user_idを指定してLineUserインスタンスを生成
      if line_user.save
        Rails.logger.debug "LINE user linked: #{line_user_id}" # デバッグ用
        redirect_to home_path, notice: 'LINEとの連携が完了しました'
        session[:line_user_id] = nil
      else
        Rails.logger.debug "Failed to create LINE user" # デバッグ用
        redirect_to home_path, alert: 'LINEとの連携に失敗しました'
      end
    elsif current_user.line_user.present?
      Rails.logger.debug "LINE user already exists" # デバッグ用
      redirect_to home_path, alert: '既にLINEとの連携が完了しています'
    else
      Rails.logger.debug "No LINE user ID in session" # デバッグ用
      redirect_to home_path, alert: 'LINEとの連携に失敗しました'
    end
  end
end
