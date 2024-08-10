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
      end
    end
    head :ok
  end
end