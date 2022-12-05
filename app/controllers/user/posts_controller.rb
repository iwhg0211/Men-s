class User::PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    impressionist(@post, nil, unique: [:ip_address])
    # この記述で同じ人の閲覧数はカウントされません！
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released)
  end

end
