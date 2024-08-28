# frozen_string_literal: true

require 'line/bot'

class LineNotifyService
  def initialize
    @client = Line::Bot::Client.new do |config|
      config.channel_id = ENV['LINE_CHANNEL_ID']
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def notify(line_user_id, message)
    message_payload = {
      type: 'text',
      text: message
    }
    response = @client.push_message(line_user_id, message_payload)

    if response.code != 200
      JSON.parse(response.read_body)['message']
    else
      Rails.logger.info "Message sent successfully to #{line_user_id}: #{message}"
    end
  end

  def send_travel_notifications
    puts 'Executing send_travel_notifications method'
    trips = Trip.where(departure_date: [7.days.from_now.to_date, 3.days.from_now.to_date, 1.day.from_now.to_date])
    puts "Trips found: #{trips.size}"

    trips.each do |trip|
      user = trip.user
      puts "Processing trip for user: #{user.id}"
      if user.line_user
        puts "User has LINE user: #{user.line_user.line_user_id}"

        days_left = (trip.departure_date - Date.today).to_i
        puts "Days left for trip: #{days_left}"

        message = case days_left
                  when 7
                    if trip.destination == 'その他の国'
                      "#{user.name}さん、旅行まであと一週間です！準備はいかがですか？パスポートやビザの有効期限を確認しましたか？また、旅行先の天気を確認して、適切な服装を準備しましょう。現地の文化やマナーについても調べておくと安心ですよ✨"
                    else
                      "#{user.name}さん、#{trip.destination}へ出発まであと一週間です！準備はいかがですか？パスポートやビザの有効期限を確認しましたか？また、旅行先の天気を確認して、適切な服装を準備しましょう。現地の文化やマナーについても調べておくと安心ですよ✨"
                    end
                  when 3
                    if trip.destination == 'その他の国'
                      "#{user.name}さん、旅行まであと3日になりました。荷造りはお済みですか？忘れ物がないようにTO DO LISTをもう一度見て必要なものをチェックしましょう!電子機器の充電器や変換プラグ、緊急連絡先のリストも忘れずに準備してくださいね🍀"
                    else
                      "#{user.name}さん、旅行まであと3日になりました。荷造りはお済みですか？忘れ物がないようにTO DO LISTをもう一度見て必要なものをチェックしましょう!電子機器の充電器や変換プラグ、緊急連絡先のリストも忘れずに準備してくださいね🍀"
                    end
                  when 1
                    if trip.destination == 'その他の国'
                      "#{user.name}さん、明日はいよいよ旅行の日です！出発までの時間を楽しんでくださいね。空港での手続きがスムーズに進むよう、チェックインの手順や手荷物の制限を再確認してください。楽しい旅行になるといいですね！気をつけて行ってらっしゃい🌼"
                    else
                      "#{user.name}さん、明日はいよいよ#{trip.destination}に出発ですね！🛩️フライトの時間と空港へのアクセスを再確認しましょう。空港での手続きがスムーズに進むよう、チェックインの手順や手荷物の制限を再確認してください。楽しい旅行になるといいですね！気をつけて行ってらっしゃい🌼"
                    end
                  end

        if message
          puts "Sending message to #{user.line_user.line_user_id}: #{message}"
          notify(user.line_user.line_user_id, message)
        else
          puts "No message to send for #{user.name} with days_left: #{days_left}"
        end
      else
        puts "No LINE user ID found for user: #{user.id}"
      end
    end
  end
end
