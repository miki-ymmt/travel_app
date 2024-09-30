# frozen_string_literal: true

class AddDefaultToUsersName < ActiveRecord::Migration[7.1]
  def up
    change_column :users, :name, :string, null: false, default: ''
  end

  def down
    change_column :users, :name, :string, null: false, default: nil
  end
end
