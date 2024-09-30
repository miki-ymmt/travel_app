# frozen_string_literal: true

# StaticPagesControllerは、アプリケーションの静的なページを管理します。

class StaticPagesController < ApplicationController
  skip_before_action :require_login

  def top; end

  def policy; end

  def terms; end
end
