# frozen_string_literal: true

# PassportsControllerは、ユーザーのパスポート情報のアップロード、更新、削除を行うコントローラーです。

class PassportsController < ApplicationController
  before_action :require_login, only: %i[new create update]
  before_action :set_passport, only: %i[update destroy]

  def new
    @passport = Passport.new
  end

  def create
    @passport = Passport.find_or_initialize_by(user: current_user)
    if @passport.update(passport_params)
      respond_to do |format|
        format.html { redirect_to @passport, notice: t('.success') }
        format.turbo_stream
      end
    else
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @passport.update(passport_params)
      respond_to do |format|
        format.html { redirect_to @passport, notice: t('.success') }
        format.turbo_stream
      end
    else
      flash.now[:alert] = t('.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @passport = Passport.find_by(id: params[:id])
    @passport.destroy
    redirect_to new_passport_path, notice: t('.success')
  end

  def set_passport
    @passport = Passport.find_by(id: params[:id])
  end

  def passport_params
    params.require(:passport).permit(:photo)
  end
end
