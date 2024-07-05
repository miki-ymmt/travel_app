class UserSessionsController < ApplicationController
    skip_before_action :require_login, only: %i[new create]

  def new ;
  end

  def create
    @user = login(params[:email], params[:password])

    if @user
      auto_login(@user)
      redirect_to home_path, notice: "ログインしました"
    else
      flash.now[:alert] = "ログインに失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other, notice: "ログアウトしました"
  end
end
