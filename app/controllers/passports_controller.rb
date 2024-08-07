class PassportsController < ApplicationController
  before_action :require_login, only: %i[new create update]
  before_action :set_passport, only: %i[new create update]

  def new
    @passport = Passport.find_or_initialize_by(user: current_user) # ユーザーに紐づくパスポートが存在する場合は取得、存在しない場合は新規作成
  end

  def create
    @passport = Passport.find_or_initialize_by(user: current_user)
    if @passport.update(passport_params)
      respond_to do |format|
        format.html { redirect_to @passport, notice: "パスポート写真を保存しました" }
        format.turbo_stream
      end
    else
      flash.now[:alert] = "パスポート写真の保存に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @passport.update(passport_params)
      respond_to do |format|
        format.html { redirect_to @passport, notice: "パスポート写真を更新しました" }
        format.turbo_stream
      end
    else
      flash.now[:alert] = "パスポート写真の更新に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end


  def set_passport
    @passport = Passport.find_by(id: params[:id])
  end

  def passport_params
    params.require(:passport).permit(:photo)
  end
end
