# frozen_string_literal: true

class AddUniqueIndexToAuthentications < ActiveRecord::Migration[7.1]
  def change
    add_index :authentications, %i[uid provider], unique: true
  end
end
