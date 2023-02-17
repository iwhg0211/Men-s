class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page]).per(10)
    # ページネーションのための記述.per(10)で１ページのうちで表示できるデータ数を10件にする
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :self_introduction, :is_deleted, :user_image)
  end

end