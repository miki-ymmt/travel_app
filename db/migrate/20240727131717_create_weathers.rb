# frozen_string_literal: true

class CreateWeathers < ActiveRecord::Migration[7.1]
  def change
    create_table :weathers do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :destination, null: false
      t.float :temperature, null: false
      t.string :description, null: false
      t.datetime :datetime, null: false
      t.datetime :fetched_at, null: false

      t.timestamps
    end
  end
end
