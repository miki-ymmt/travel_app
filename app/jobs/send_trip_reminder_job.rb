# frozen_string_literal: true

class SendTripReminderJob < ApplicationJob
  queue_as :default

  def perform(*_args)
    LineNotifyService.new.send_travel_notifications # 旅行の出発日に応じてLINEユーザーに通知を送信
  end
end
