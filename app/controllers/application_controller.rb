# frozen_string_literal: true

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
    redirect_to login_path, alert: 'ログインしてください'
  end
end
