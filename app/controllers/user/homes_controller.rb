class User::HomesController < ApplicationController
  def top
    @post_ranks = Post.all
  end

  def about
  end
end
