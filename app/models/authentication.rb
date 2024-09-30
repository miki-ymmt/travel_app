# frozen_string_literal: true

# Authenticationは、ユーザーの外部サービス認証情報を管理するモデルです。

class Authentication < ApplicationRecord
  belongs_to :user

  validates :provider, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }
end
