require 'line/bot'

class LineNotifyService
  def initialize # LINEクライアントを初期化
    @client = Line::Bot::Client.new do |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def notify(line_user_id, message) # LINEユーザーにメッセージを送信
    message_payload = {
        type: 'text',
        text: message
    }
    response = @client.push_message(line_user_id, message_payload)
    if response.code != 200
      puts "Error: #{response.read_body}"
    else
      puts "Message sent successfully to #{line_user_id}: #{message}"
    end
  end

  def send_travel_notifications # 旅行の出発日に応じてLINEユーザーに通知を送信
    trips = Trip.where(departure_date: [7.days.from_now.to_date, 3.days.from_now.to_date, 1.day.from_now.to_date])
    trips.each do |trip|
      user = trip.user
      next unless user.line_user

      days_left = (trip.departure_date - Date.today).to_i
      message = case days_left
                when 7
                  "#{user.name}さん、旅の出発まであと一週間です！準備はいかがですか？パスポートやビザの有効期限を確認しましたか？また、旅行先の天気を確認して、適切な服装を準備しましょう。現地の文化やマナーについても調べておくと安心ですよ✨"
                when 3
                  "旅行まであと3日になりました。荷造りはお済みですか？忘れ物がないようにTO DO LISTをもう一度見て必要なものをチェックしましょう!電子機器の充電器や変換プラグ、緊急連絡先のリストも忘れずに準備してくださいね🍀"
                when 1
                  "明日はいよいよ#{trip.destination}に出発です！フライトの時間と空港へのアクセスを再確認しましょう。空港での手続きがスムーズに進むよう、チェックインの手順や手荷物の制限を再確認してください。楽しい旅行になるといいですね！行ってらっしゃい🌼"
                else
                  nil
                end

      if message
        puts "Sending message to #{user.line_user.line_user_id}: #{message}"
        notify(user.line_user.line_user_id, message)
      else
        puts "No message to send for #{user.name} with days_left: #{days_left}"
      end
    end
  end
end

