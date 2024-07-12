class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password_confirmation
  has_many :trips, dependent: :destroy
  has_many :todos, through: :trips
  has_one :passport, dependent: :destroy

  validates :name, length: { maximum:10}, presence: true
  validates :password, confirmation: true, length: { minimum: 4, maximum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
end
