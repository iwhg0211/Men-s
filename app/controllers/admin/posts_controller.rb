class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path(@post.id)
  end

  def show
    @post = Post.find(params[:id])
    @reviews = @post.reviews
    #↑@postに紐づいたreviewを取得して@reviewsに格納
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

end