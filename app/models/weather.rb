# frozen_string_literal: true

# Weatherは、特定の旅行に関連する天気情報を管理します。
# 旅行先の天気予報や温度を保持します。

class Weather < ApplicationRecord
  belongs_to :trip

  validates :destination, presence: true
  validates :temperature, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :fetched_at, presence: true

  def self.recent_for_trip(trip_id)
    where(trip_id:).where(fetched_at: 1.minute.ago..).order(fetched_at: :desc).first
  end
end
