class Trip < ApplicationRecord
  belongs_to :user
  has_many :todos, dependent: :destroy

  validates :destination, presence: true
  validates :departure_date, presence: true
  validates :return_date, presence: true
end
