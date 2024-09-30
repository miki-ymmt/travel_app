# frozen_string_literal: true

# LineBotControllerは、LINEのボットとのやり取りを処理するコントローラーです。
# LINE Messaging APIを使ってメッセージの送受信を管理します。

class LineBotController < ApplicationController
  protect_from_forgery except: [:callback] # CSRF対策無効化
  skip_before_action :require_login, only: [:callback]

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = ENV.fetch('LINE_CHANNEL_ID', nil)
      config.channel_secret = ENV.fetch('LINE_CHANNEL_SECRET', nil)
      config.channel_token = ENV.fetch('LINE_CHANNEL_TOKEN', nil)
    end
  end

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    return head :bad_request unless client.validate_signature(body, signature)

    client.parse_events_from(body).each do |event|
      if event.is_a?(Line::Bot::Event::Follow)
        line_user_id = event['source']['userId']
        Rails.logger.debug { "Received LINE user ID: #{line_user_id}" }
      end
    end
    head :ok
  end
end
