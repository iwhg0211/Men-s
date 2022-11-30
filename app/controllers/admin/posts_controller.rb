class Admin::PostsController < ApplicationController
  def index
    @posts = Post.all.page(params[:page]).per(10)
  end

  def show
  end
end
