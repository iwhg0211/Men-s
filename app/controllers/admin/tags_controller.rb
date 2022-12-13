class Admin::TagsController < ApplicationController

  def index
    @tags = Tag.all
    @tag = Tag.new
  end
  
  def create
    #tag = Tag.new(tag_para)
    #tag.save
    #render :index
    binding.pry
    @post = Post.find(params[:post_id])
    redirect_to root_path
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  private

  def tag_params
    params.require(:tag).permit(:tag_name, :post_id)
  end

end