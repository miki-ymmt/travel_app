# frozen_string_literal: true

class AddUniqueIndexToUsersResetPasswordToken < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, :reset_password_token if index_exists?(:users, :reset_password_token)
    add_index :users, :reset_password_token, unique: true
  end
end
