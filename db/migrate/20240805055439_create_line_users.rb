# frozen_string_literal: true

class CreateLineUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :line_users do |t|
      t.references :user, null: false, foreign_key: true
      t.string :line_user_id, null: false

      t.timestamps
    end

    add_index :line_users, :line_user_id, unique: true
  end
end
