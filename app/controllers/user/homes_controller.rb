class User::HomesController < ApplicationController
  #before_action :authenticate_user!, except: [:top, :about]
  def top
    @post_ranks = Post.all.page(params[:page]).per(3)
  end

  def about
  end
  
  def guest_sign_in
   user = User.find_or_create_by(email: 'guest@example.com') do |user|
     #find_or_create_byはどんな働き？
     user.password = SecureRandom.urlsafe_base64
     user.last_name = "ゲスト"
     user.first_name = "太郎"
     user.last_name_kana = "ゲスト"
     user.first_name_kana = "タロウ"
     user.user_name = "ゲストユーザー"
   end
   sign_in user
   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
 
end
