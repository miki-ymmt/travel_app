# frozen_string_literal: true

# ApplicationControllerは、全てのコントローラーの基本クラスです。
# ここに記述されたメソッドや設定は、他のコントローラーで共通して使用されます。

class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_locale
  helper_method :current_user

  def set_locale
    I18n.locale = :ja
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  def not_authenticated
    redirect_to login_path, alert: t('messages.login_required')
  end
end
