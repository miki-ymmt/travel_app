# frozen_string_literal: true

class CreatePassports < ActiveRecord::Migration[7.1]
  def change
    create_table :passports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :photo

      t.timestamps
    end
  end
end
