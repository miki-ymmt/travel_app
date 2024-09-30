# frozen_string_literal: true

# UserSessionsControllerは、ユーザーのログイン・ログアウトに関する処理を行うコントローラです。

class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      redirect_to home_path, notice: t('sessions.create.success')
    else
      flash.now[:alert] = t('sessions.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, notice: t('sessions.destroy.success')
  end
end
