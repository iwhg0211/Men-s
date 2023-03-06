class Admin::PostsController < ApplicationController
  
  def index
    @posts = Post.all.page(params[:page]).per(10)
    # 投稿されたpostデータを一覧で表示する１ページに10件まで
  end

  def update
    @post = Post.find(params[:id])
    # views/admin/posts/show.html.erbの<%= form_with model: @post, url: admin_post_path do |f| %>で@postに入れられたデータ(どのidか)を見つける
    @post.update(post_params)
    # post_paramsに入れられた@postデータを更新
    redirect_to admin_post_path(@post.id)
    # @post.idに遷移
  end

  def show
    @post = Post.find(params[:id])
    # @postに入れられているidを見つける→showは表示だけ
    @reviews = @post.reviews
    #↑@postに紐づいたreviewを取得して@reviewsに格納
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
    # postのハッシュの値だけ取得できるのでそれ以外の意味わからないものは取得しない。セキュリティのためのストロングパラメータ
  end

end