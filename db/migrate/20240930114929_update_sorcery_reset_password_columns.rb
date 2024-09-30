# frozen_string_literal: true

class UpdateSorceryResetPasswordColumns < ActiveRecord::Migration[7.1]
  def up
    change_table :users, bulk: true do |t|
      t.change :reset_password_token, :string, default: nil
      t.change :reset_password_token_expires_at, :datetime, default: nil
      t.change :reset_password_email_sent_at, :datetime, default: nil
      t.change :access_count_to_reset_password_page, :integer, default: 0
    end
  end

  def down
    change_table :users, bulk: true do |t|
      # 元に戻す処理を記述
      t.change :reset_password_token, :string, default: nil
      t.change :reset_password_token_expires_at, :datetime, default: nil
      t.change :reset_password_email_sent_at, :datetime, default: nil
      t.change :access_count_to_reset_password_page, :integer, default: nil
    end
  end
end
