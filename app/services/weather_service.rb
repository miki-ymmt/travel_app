# frozen_string_literal: true

# ライブラリの読み込み
require 'httparty'

class WeatherService
  include HTTParty
  # APIのベースURIを設定
  base_uri 'https://api.openweathermap.org/data/2.5'

  CITY_TRANSLATIONS = {
    'ロサンゼルス' => 'Los Angeles',
    'ニューヨーク' => 'New York',
    'ロンドン' => 'London',
    'パリ' => 'Paris',
    '台北' => 'Taipei',
    'ソウル' => 'Seoul',
    'バンコク' => 'Bangkok',
    'シンガポール' => 'Singapore',
    'シドニー' => 'Sydney',
    'ハワイ' => 'Hawaii',
    'クアラルンプール' => 'Kuala Lumpur',
    'マドリード' => 'Madrid',
    'ミュンヘン' => 'Munich',
    'ローマ' => 'Rome',
    '上海' => 'Shanghai',
    '香港' => 'Hong Kong',
    'ホーチミン' => 'Ho Chi Minh',
    'アムステルダム' => 'Amsterdam',
    'ブリュッセル' => 'Brussels'
  }.freeze

  def initialize
    # APIキーを環境変数から取得
    @api_key = ENV['OPENWEATHERMAP_API_KEY']
  end

  def fetch_weather(city)
    # 日本語の都市名を英語に変換
    english_city = CITY_TRANSLATIONS[city] || city
    puts "Translating city: #{city} to #{english_city}" # デバッグ情報を追加

    # APIを叩いて天気情報を取得
    options = { query: { q: english_city, appid: @api_key, units: 'metric', lang: 'ja' } }
    puts "Requesting weather data for #{english_city} with options: #{options.inspect}" # デバッグ情報

    response = self.class.get('/weather', options)
    if response.success?
      puts "API Response: #{response.parsed_response.inspect}" # デバッグ情報を追加
      # 取得した天気情報を返す
      response.parsed_response
    else
      puts "Failed to fetch weather data: #{response.code} - #{response.message}" # デバッグ情報
      puts "Response body: #{response.body}" # レスポンスボディを出力
      # エラーが発生した場合はエラー情報を返す
      { 'error' => '天気情報の取得に失敗しました' }
    end
  end
end
