# frozen_string_literal: true

# HomeControllerは、アプリケーションのホームページを管理します。
# ユーザーがログインした後に表示されるメインのダッシュボードを提供します。

class HomeController < ApplicationController
  before_action :require_login

  def index
    @next_trip = current_user.next_trip
    Rails.logger.debug { "Next Trip: #{@next_trip.inspect}" } # デバッグ情報を追加

    # ユーザーに紐づく次の旅行が存在する場合は取得、存在しない場合はnil
    if @next_trip
      # キャッシュが存在しない場合はAPIから取得
      @weather_info = fetch_or_get_cashed_weather(@next_trip)
      Rails.logger.debug { "@weather_info: #{@weather_info.inspect}" }
      if @weather_info
        Rails.logger.debug { "@weather_info[:description]: #{@weather_info[:description].inspect}" } # デバッグ情報を追加
      end
    else
      Rails.logger.debug { "No upcoming trip found for user: #{current_user.id}" } # デバッグ情報を追加
    end
  end

  private

  def fetch_or_get_cashed_weather(trip)
    # 旅行の最近の天気情報をDBから取得
    weather = Weather.recent_for_trip(trip.id)
    Rails.logger.debug { "Fetched weather from DB: #{weather.inspect}" } # デバッグ情報を追加

    # もし天気情報が存在しない場合はAPIから取得
    if weather.nil?
      weather_data = fetch_weather(trip.destination)
      Rails.logger.debug { "Fetched weather from API: #{weather_data.inspect}" } # デバッグ情報を追加

      if weather_data && weather_data['main'] && weather_data['weather']
        weather = Weather.create(
          trip_id: trip.id,
          destination: trip.destination,
          temperature: weather_data['main']['temp'],
          description: weather_data['weather'][0]['description'],
          datetime: Time.zone.at(weather_data['dt']),
          fetched_at: Time.current
        )
        Rails.logger.debug { "Weather data saved to DB: #{weather.inspect}" } # デバッグ情報を追加
      end
      Rails.logger.debug { "Weather data from API is invalid: #{weather_data.inspect}" } # デバッグ情報を追加
      return { error: '天気情報の取得に失敗しました' }
    end

    {
      destination: weather.destination,
      temperature: weather.temperature,
      description: weather.description,
      datetime: weather.datetime
    }
  end

  # 指定された目的地の天気情報を取得
  def fetch_weather(destination)
    # WeatherServiceクラスのインスタンスを作成
    weather_service = WeatherService.new
    # WeatherServiceクラスのfetch_weatherメソッドを呼び出し、天気情報を取得
    weather_service.fetch_weather(destination)
  end
end
