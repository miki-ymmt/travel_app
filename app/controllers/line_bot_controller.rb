class LineBotController < ApplicationController
  before_action :authenticate_user!, only: [:callback] # ユーザーがログインしていることを確認

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
      return
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Follow # ユーザーがLINE公式アカウントを友達追加したとき
        handle_follow(event)
      when Line::Bot::Event::Message # ユーザーがメッセージを送信したとき
        handle_message(event)
      end
    end

    head :ok
  end

  private

  def handle_follow(event)
    line_user_id = event['source']['userId']
    puts "Received LINE user ID: #{line_user_id}" # デバッグ用ログ

    user = current_user # ログインしているユーザーを取得
    if user # ログインしているユーザーが存在する場合
      puts "Current user ID: #{user.id}" # デバッグ用ログ
      user.create_line_user(line_user_id: line_user_id) # 新しいレコードを作成し、ユーザーとLINEユーザーを関連付ける
      puts "LINE user created for user ID: #{user.id}" # デバッグ用ログ
    else
      puts "No current user found" # デバッグ用ログ
      message = {
        type: 'text',
        text: 'ユーザーを特定できませんでした。再度お試しください。'
      }
      client.reply_message(event['replyToken'], message)
    end
  end

  def handle_message(event)
    line_user_id = event['source']['userId']
    puts "Received LINE user ID from message: #{line_user_id}" # デバッグ用ログ

    user = current_user # ログインしているユーザーを取得
    if user && user.line_user.nil? # ログインしているユーザーが存在し、LINEユーザーが関連付けられていない場合
      puts "Current user ID: #{user.id}" # デバッグ用ログ
      user.create_line_user(line_user_id: line_user_id) # 新しいレコードを作成し、ユーザーとLINEユーザーを関連付ける
      puts "LINE user created for user ID: #{user.id}" # デバッグ用ログ
    else
      puts "No current user found or LINE user already exists" # デバッグ用ログ
    end

    case event.type
    when Line::Bot::Event::MessageType::Text
      message = {
        type: 'text',
        text: event.message['text']
      }
      client.reply_message(event['replyToken'], message)
    end
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end
end
