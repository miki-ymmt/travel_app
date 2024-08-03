class ChatbotsController < ApplicationController
  before_action :require_login

  def ask #ユーザーがアクセスして質問を入力するページを表示
  end

  def answer #ユーザーが質問を入力して送信すると、質問をOpenAIに送信して回答を取得
    client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])

    prompt = params[:question] #ユーザーが入力した質問を取得

    response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: [
          { role: "system", content: "あなたは海外旅行初心者に役立つ優秀な旅行アシスタントです。ユーザーの質問に対して、日本語で明確かつ簡潔な旅行アドバイスを提供してください。300字以内で書いてください。リストや重要なポイントを箇条書きで改行してください。各ポイントには具体例や説明を加えてください。記号やマークダウン形式（**など）は使用しないでください。" },
          { role: "user", content: prompt }
        ],
        max_tokens: 500,
        temperature: 0.7
      }
    )

    Rails.logger.debug "OpenAI response: #{response.inspect}" #デバッグ情報を追加

    if response["choices"] && response["choices"][0] && response["choices"][0]["message"]
      @answer = response["choices"][0]["message"]["content"]
    else
      @answer = "回答が見つかりませんでした"
    end

    respond_to do |format|
      format.turbo_stream
    end
  end
end