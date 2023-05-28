class User::HomesController < ApplicationController
  def top
    @tag_lists = Tag.all
  end

  def about
  end
  
  def guest_sign_in
   user = User.find_or_create_by(email: 'guest@example.com') do |user|
     # find_or_create_byは()を見つけて、あるなしで条件を決める
     user.password = SecureRandom.urlsafe_base64
     # ランダムで64文字を組み合わせてパスワードを生成
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
