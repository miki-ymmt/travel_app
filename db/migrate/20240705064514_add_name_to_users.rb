# frozen_string_literal: true

# rubocop:disable Rails/NotNullColumn
class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
  end
end

# rubocop:enable Rails/NotNullColumn
