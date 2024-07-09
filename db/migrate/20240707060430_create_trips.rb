class CreateTrips < ActiveRecord::Migration[7.1]
  def change
    create_table :trips do |t|
      t.references :user, null: false, foreign_key: true
      t.string :destination, null: false
      t.date :departure_date, null: false
      t.date :return_date, null: false
      t.text :notes

      t.timestamps
    end
  end
end
