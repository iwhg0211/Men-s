class Admin::ReviewsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @reviews = @post.reviews.page(params[:page]).per(10)
    #binding.pry
  end

  def show
    @review = Review.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  private

  def review_params
    params.require(:review).permit(:post_id, :review_title, :shop_review, :is_released)
  end

end