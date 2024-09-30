# frozen_string_literal: true

# パスポート写真のアップロードを行うためのモデル

class Passport < ApplicationRecord
  belongs_to :user
  mount_uploader :photo, PhotoUploader

  validates :photo, presence: true
end
