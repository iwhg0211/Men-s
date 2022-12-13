class User::ReviewsController < ApplicationController
  def new
    #@user = User.find(params[:id])
    # bindin.pryしたら=> #<ActionController::Parameters {"controller"=>"user/reviews", "action"=>"new"} permitted: false>
    # idがないので、どうしたら渡せるのか考えないと
    #@post = Post.find(params[:id])
    @user_id = current_user.id
    # 誰がレビューするの？=>今ログインしているユーザーなので「current_user」
    @post_id = params[:post_id]
    # どの投稿にコメントするの？=>reviewのshowでidを渡した、new_review_path(post_id: @post.id)のidにコメントするで
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to root_path
    # 12/10現在、レビューが保存できていない。rails cで確認済み=>12/11解決済み
    # reviewを、誰が（カレントユーザーが）、どの投稿（もとのpostのshowのidは？）に書くのかということを記述できていなかった
  end

  def index
  end

  def show
  end

  def edit
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