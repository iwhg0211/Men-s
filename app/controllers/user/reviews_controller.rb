class User::ReviewsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    # どの投稿にコメントするの？=>reviewのshowでidを渡した、new_review_path(post_id: @post.id)のidにコメントするで
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    #newから受け取ったレビューの各種内容を持ってくるnew⇨review_params⇨createと飛ばして行っている
    @review.user_id = current_user.id
    # @review.user_idで@reviewのuser_idに、current_user.idを入れる。これで@reviewに必要な情報を渡すことができる
    if @review.save
      redirect_to posts_path
    else
      redirect_to posts_path
      flash[:cannot_save_of_reviews] = "レビューの星を入力してください。レビューの保存はされませんでした。"
    end
    # reviewを、誰が（カレントユーザーが）、どの投稿（もとのpostのshowのidは？）に書くのかということを記述できていなかった
  end

  def index
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @review.update(review_params)
    redirect_to review_path(@review.id)
  end

  private

  def review_params
    params.require(:review).permit(:post_id, :user_id, :review_title, :shop_review, :rate, :is_released)
  end

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

  def user_params
    params.require(:user).permit(:email, :password, :last_name, :first_name, :last_name_kana, :first_name_kana, :user_name, :self_introduction, :is_deleted, :user_image)
  end

end