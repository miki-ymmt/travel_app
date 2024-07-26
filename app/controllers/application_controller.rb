class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :set_locale

  def set_locale
    I18n.locale = :ja
  end

  private

  def not_authenticated
  redirect_to login_path, alert: "ログインしてください"
  end
end
