class Admin::ReviewsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    #↑postにreviewでルーティングのネストがされている。rails routesでURI Pattern を確認すると、posts/:post_id/reviews/:idとなっている。(下の行に続く)
    #(上の行の続き)なので、postのidをとりにいくときはfind(params[:post_id]),reviewのidをとりにいくときはfind(params[:id])と記述する
    @reviews = @post.reviews.page(params[:page]).per(10)
    #↑@postに紐づいたreviewを@postに格納。page(params[:page])でページネーション実装、per(10)で１ページに10件まで
  end

  def show
    @review = Review.find(params[:id])
    @post = Post.find(params[:post_id])
  end

  def update
    @post = Post.find(params[:post_id])
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to admin_post_review_path(@post.id, @review.id)
  end

  private

  def review_params
    params.require(:review).permit(:post_id, :review_title, :shop_review, :is_released)
  end

end