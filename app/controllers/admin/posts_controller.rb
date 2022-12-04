class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end
  
  def create
  end

  def show
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_deleted, :post_image)
  end

end