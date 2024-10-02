# frozen_string_literal: true

# ApplicationHelperは、ビューで使用する汎用的なヘルパーメソッドを定義するモジュールです。

module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice, :default then 'bg-blue-300'
    when :alert then 'bg-orange-300'
    when :error then 'bg-yellow-200'
    else 'bg-blue-300' # デフォルト値
    end
  end
end
