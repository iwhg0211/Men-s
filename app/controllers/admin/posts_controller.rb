class Admin::PostsController < ApplicationController
  def index
    @users = User.all
    #@user = User.find(params[:id])
    @posts = Post.all.page(params[:page]).per(10)
  end

  def create
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end

  def show
    @user = User.find(params[:id])
    @post = Post.find(params[:id])
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

end