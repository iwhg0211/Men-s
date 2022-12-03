class Admin::TagsController < ApplicationController
  
  def index
    @tags = Tag.all
  end

  def edit
    @tag = Tag.find(params[:id])
  end
  
  private
  
  def tag_params
    params.require(:tag).permit(:tag_name)
  end
  
end
