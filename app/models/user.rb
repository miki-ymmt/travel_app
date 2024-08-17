class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password_confirmation
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  has_many :trips, dependent: :destroy
  has_many :todos, through: :trips
  has_one :passport, dependent: :destroy
  has_one :line_user, dependent: :destroy

  validates :name, length: { maximum:10}, presence: true
  validates :password, confirmation: true, length: { minimum: 4, maximum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # 未来の旅行を取得
  def next_trip
    trips.where("departure_date >= ?", Date.today).order(:departure_date).first
  end
end
