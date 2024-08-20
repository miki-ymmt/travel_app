# frozen_string_literal: true

class Trip < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy
  has_many :weathers, dependent: :destroy

  validates :destination, presence: true
  validates :departure_date, presence: true
  validates :return_date, presence: true

  def update_weather_if_destination_changed
    return unless destination_changed?

    weathers.destroy_all
    add_weather
  end

  def add_weather
    weather_data = WeatherService.new.fetch_weather(destination)
    return unless weather_data && weather_data['main'] && weather_data['weather']

    weathers.create(
      temperature: weather_data['main']['temp'],
      description: weather_data['weather'][0]['description'],
      datetime: Time.at(weather_data['dt']),
      fetched_at: Time.current
    )
  end
end
