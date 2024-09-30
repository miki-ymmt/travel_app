# frozen_string_literal: true

class AddNotNullToTodosDone < ActiveRecord::Migration[7.1]
  def change
    change_column_null :todos, :done, false
  end
end
