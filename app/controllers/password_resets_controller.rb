# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    @user = User.find_by(email: params[:email])

    if @user
      @user.deliver_reset_password_instructions!
      redirect_to login_path, notice: 'パスワードリセットのメールを送信しました'
    else
      flash.now[:alert] = 'ユーザーが見つかりません'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])
    not_authenticated if @user.blank?
  end

  def update
    @token = params[:id]
    @user = User.load_from_reset_password_token(params[:id])

    if @user.blank?
      not_authenticated
      return
    end

    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.change_password(params[:user][:password])
      redirect_to login_path, notice: 'パスワードを更新しました'
    else
      flash.now[:alert] = 'パスワードを更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end
end
