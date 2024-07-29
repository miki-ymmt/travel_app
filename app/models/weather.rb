class Weather < ApplicationRecord
  belongs_to :trip

  validates :destination, presence: true
  validates :trip_id, presence: true
  validates :temperature, presence: true
  validates :description, presence: true
  validates :datetime, presence: true
  validates :fetched_at, presence: true


  def self.recent_for_trip(trip_id)
    where(trip_id: trip_id).where('fetched_at >= ?', 1.minute.ago).order(fetched_at: :desc).first
  end
end
