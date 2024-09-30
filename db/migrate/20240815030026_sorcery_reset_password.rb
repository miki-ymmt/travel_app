# frozen_string_literal: true

class SorceryResetPassword < ActiveRecord::Migration[7.1]
  def up
    change_table :users, bulk: true do |t|
      t.string :reset_password_token, default: nil
      t.datetime :reset_password_token_expires_at, default: nil
      t.datetime :reset_password_email_sent_at, default: nil
      t.integer :access_count_to_reset_password_page, default: 0
    end
  end

  def down
    change_table :users, bulk: true do |t|
      t.remove :reset_password_token
      t.remove :reset_password_token_expires_at
      t.remove :reset_password_email_sent_at
      t.remove :access_count_to_reset_password_page
    end
  end
end
