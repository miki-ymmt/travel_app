class LineBotController < ApplicationController
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
      when Line::Bot::Event::Follow #ユーザーがLINE公式アカウントを友達追加したとき
        line_user_id = event['source']['userId']
        # ここでline_user_idをデータベースに保存するロジックを追加
        user = current_user #ログインしているユーザーを取得
        if user #ログインしているユーザーが存在する場合
          user.create_line_user(line_user_id: line_user_id) #新しいレコードを作成し、ユーザーとLINEユーザーを関連付ける
        else
          message = {
            type: 'text',
            text: 'ユーザーを特定できませんでした。再度お試しください。'
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    end

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end

  def handle_message(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      message = {
        type: 'text',
        text: event.message['text']
      }
      client.reply_message(event['replyToken'], message)
    end
  end
end
