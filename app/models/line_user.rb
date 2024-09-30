# frozen_string_literal: true

# LINEユーザー情報を管理するモデル

class LineUser < ApplicationRecord
  belongs_to :user

  validates :line_user_id, presence: true, uniqueness: true
end
