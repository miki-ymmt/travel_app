# frozen_string_literal: true

module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then 'bg-blue-300'
    when :alert then 'bg-orange-200'
    when :error then 'bg-yellow-200'
    else 'bg-blue-300'
    end
  end
end
