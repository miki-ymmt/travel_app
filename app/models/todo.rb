# frozen_string_literal: true

# ToDoは、ユーザーが旅行のために設定した個々のタスクを表します。
# これにより、旅行に必要なアイテムや準備事項を管理できます。

class Todo < ApplicationRecord
  belongs_to :trip
  validates :content, presence: true
end
