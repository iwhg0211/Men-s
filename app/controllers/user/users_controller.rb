class User::UsersController < ApplicationController

  # def index
  #   @users = User.all.page(params[:page])
  # end

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
    @user = current_user
    #↑current_userの情報をとるときはこのくらいシンプルにとる。
    # 前までやっていたcurrent_user.idにしてしまうとidしか取ってこなくなるので、このくらいシンプルに書く
  end

  def edit_mypage
    @user = current_user
  end

  def update_mypage
    @user = current_user
    current_user.update(user_params)
    redirect_to mypage_path
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    #binding.pry
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      reset_session
      redirect_to :root
    else
      # パラメータ⇨画面（view）から飛んでくるもの、ユーザーなどの情報、
      # 退会するユーザーのidを見つける
      #@user.update(user_params)
      @user.update(is_deleted: :true)
      # is_deletedをtrue(退会)にupdateする
      reset_session
      # セッション情報を全て削除します。
      flash[:notice] = "退会処理を実行しました"
      # viewにflashメッセージを表示するため
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :self_introduction, :is_deleted, :user_image)
  end

end
