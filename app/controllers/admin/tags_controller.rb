class Admin::TagsController < ApplicationController

  def index
    @tag_lists = Tag.all
  end
  
  def tag_index
    @tags = Tag.where(post_id :post_id)
  end

  def create
    #tag = Tag.new(tag_para)
    #tag.save
    #render :index
    @post = Post.find(params[:post_id])
    redirect_to root_path
  end

  def edit
    @tag_lists = Tag.find(params[:id])
  end

  def update
    @tag_lists = Tag.find(params[:id])
    @tag_lists.update(tag_params)
    redirect_to admin_tags_path
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name, :post_id)
  end

end