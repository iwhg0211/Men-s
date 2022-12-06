# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def reject_user
    # 会員の論理削除のための記述。退会後は、同じアカウントでは利用できない。
    @user = User.find_by(name: params[:user][:user_name])
    # ログイン時に入力された名前に対応するユーザーが存在するか探しています。
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted == true)
        # 入力されたパスワードが正しいことを確認しています。
        # ＠userのactive_for_authentication?メソッドがtrueであるかどうか。
        # パスワードが正しく、退会(true)のユーザーであれば、新規登録(new_user_registration_path)に遷移するようにしている
        redirect_to new_user_registration_path
      else
        flash[:notice] = "項目を入力してください"
      end
    end
  end
  
end