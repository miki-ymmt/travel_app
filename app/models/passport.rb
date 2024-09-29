# frozen_string_literal: true

class Passport < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
end
