class Admin::ReviewsController < ApplicationController
  
  def index
    @reviews = Review.all.page(params[:page]).per(10)
    @review = Review.find(params[:id])
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:post_id, :review_title, :shop_review, :is_released)
  end

end