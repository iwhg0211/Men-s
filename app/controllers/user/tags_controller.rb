class User::TagsController < ApplicationController

  def create
    #tag = Tag.new(tag_para)
    #tag.save
    #render :index
    #binding.pry
    @post = Post.find(params[:tag][:post_id])
    @tag_list = params[:tag][:tag_name].split(",")
    # binding.pry
    if @post.save_tag(@tag_list)
       #binding.pry
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
