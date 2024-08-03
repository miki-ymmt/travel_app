require 'openai'

OpenAI.configure do |config|
  config.access_token = ENV.fetch("OPENAI_API_KEY")
  config.log_errors = true # 開発時にエラーを確認できるようにする。本番環境ではfalseにする
end