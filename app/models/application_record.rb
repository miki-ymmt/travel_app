# frozen_string_literal: true

# ApplicationRecordは、すべてのモデルに共通の設定を持つベースクラスです。

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
