# frozen_string_literal: true

# UsersControllerは、ユーザーの登録、編集、更新、削除などの操作を管理するコントローラです。

class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  before_action :set_locale

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to home_path, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user, notice: t('.success')
    else
      flash.now[:alert] = t('.failure')
      render :edit
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    reset_session
    redirect_to root_path, status: :see_other, notice: t('.success')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
