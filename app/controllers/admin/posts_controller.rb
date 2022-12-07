class Admin::PostsController < ApplicationController
  def index
    @users = User.all
    @user = User.find(params[:id])
    @posts = Post.all.page(params[:page]).per(10)
  end

  def create
  end

  def show
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
    impressionist(@post, nil, unique: [:ip_address])
    # この記述で同じ人の閲覧数はカウントされません！
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_deleted, :post_image)
  end

end