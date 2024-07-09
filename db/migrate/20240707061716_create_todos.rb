class CreateTodos < ActiveRecord::Migration[7.1]
  def change
    create_table :todos do |t|
      t.references :trip, null: false, foreign_key: true
      t.string :content, null: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
