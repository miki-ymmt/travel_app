# frozen_string_literal: true

# PagesControllerは、静的なページを管理するコントローラーです。
# アプリの使い方のページを表示します。

class PagesController < ApplicationController
  skip_before_action :require_login

  def usage_instructions; end
end
