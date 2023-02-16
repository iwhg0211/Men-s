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
       flash[:cannot_save_of_tags] = "「タグ名」を入力してください。"
       redirect_to post_path(@post.id)
       #flash[:cannot_save_of_tags] = "「タグ名」を入力してください。"
    end
  end
  
#   def search
#     @tag_lists = Tag.tagged_with([params[:search_tag]]).order("created_at DESC").page(params[:page]).per(5)
#   end

# #以下のactionを追記
#   def autocomplete
#     all_tags = Tag.tag_counts_on(:tag_) #全てのタグを取得
#     tags_name = all_tags.where('tag_name LIKE(?)', "#{params[:term]}%").pluck(:tag_name) #tagsテーブルのnameカラムを前方一致で取得
#     render json: tags_name.to_json #前方一致で取得した値をjsonにする
#   end

  private

  def tag_params
    params.require(:tag).permit(:tag_name, :post_id)
  end

  # def autocomplete_params
  #   params.permit(:tag_name)
  # end

end