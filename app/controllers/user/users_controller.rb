class User::UsersController < ApplicationController

  def index
    @users = User.all.page(params[:page])
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
    redirect_to user_path(@user.id)
  end

  def mypage
    @user = User.find(params[:id])
  end

  def edit_mypage
    @user = User.current_scope
  end

  def update_mypage
    @user = User.current_scope
    @user.update(user_params)
    redirect_to mypage_path
  end

  def unsubscribe
    @user = User.find_by(email: params[:user][:email])
  end

  def withdraw
    #binding.pry
    @user = User.find_by(email: params[:user][:email])
    # 退会するユーザーのidを見つける
    @user.update(user_params)
    #@user.update(is_deleted :true)
    # is_deletedをtrue(退会)にupdateする
    reset_session
　　# セッション情報を全て削除します。
    flash[:notice] = "退会処理を実行しました"
    # viewにflashメッセージを表示するため
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :self_introduction, :is_deleted, :user_image)
  end

end
