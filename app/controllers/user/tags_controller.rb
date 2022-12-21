class User::TagsController < ApplicationController

  def index
    tag = Tag.find(params[:id])
    @posts = tag.posts
    #↑の記述はタグのidに紐づいた投稿の取得
    @tag = Tag.find(params[:id])
    #↑の記述はタグ名を表示するため
  end

  def create
    @post = Post.find(params[:tag][:post_id])
    @tag_list = params[:tag][:tag_name].split(",")
    if @post.save_tag(@tag_list)
       redirect_to post_path(@post.id)
    else
       redirect_to post_path(@post.id)
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name, :post_id)
  end

end