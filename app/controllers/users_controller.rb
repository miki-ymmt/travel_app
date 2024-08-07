class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_locale

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      redirect_to home_path, notice: "アカウントを作成しました"
    else
      flash.now[:alert] = "アカウントの作成に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'アカウント情報が更新されました。'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
