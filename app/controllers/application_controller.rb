class ApplicationController < ActionController::Base

  #before_action :authenticate_user!, except: [:top, :about]

  def after_sign_in_path_for(resource_or_scope)
    # サインインした後に遷移する場所を指定する
      if resource_or_scope.is_a?(Admin)
        # Adminがログインしているか確認する
          admin_posts_path
          # adminの投稿一覧に遷移する
      else
        # それ以外がログインしているなら、userのトップページ遷移する
          root_path
      end
  end

  def after_sign_out_path_for(resource_or_scope)
    # サインアウトした後に遷移する場所を指定する
      if resource_or_scope == :user
        # userがログアウトした後に遷移する場所を指定する
          root_path
          # トップページに遷移する
      elsif resource_or_scope == :admin
        # admin(管理者)がログアウトした後に遷移する場所を指定する
          new_admin_session_path
          # adminのログインページに遷移する
      end
  end
  
end