class User::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  def unsubscribe
    @user = User.find(params[:id])
  end
  
  def withdraw
    @user = User.find(params[:id])
    # 退会するユーザーのidを見つける
    @user.update(is_deleted :true)
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
