class User::PostsController < ApplicationController
  def index
    @tag_list = Tag.all              #ビューでタグ一覧を表示するために全取得。
    @posts = Post.all.page(params[:page])
    @post = current_user.posts.new   #ビューのform_withのmodelに使う。
    @users = User.all
    @all_ranks = Post.find(Post.group(:id).order('count(id) desc').limit(3).pluck(:id))
  end

  def new
    @post = Post.new
    @tag_lists = Tag.all
  end

  #def create
    #@post = Post.new(post_params)
    #@post.save
    #redirect_to post_path(@post.id)
  def create
    @post = current_user.posts.new(post_params)
    @tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tag(@tag_list)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  #end

  def show
    #@users = User.all
    @post = Post.find(params[:id])
    #↑クリックした投稿を取得
    @tag_posts = @post.tags
    #そのクリックした投稿に紐付けられているタグの取得。
    #ここは参考にしたところはpost_tagsだったが、テーブル名の都合上@tag_postsにした
    @user = User.find(@post.user_id)
    #impressions(@post, nil, unique: [:ip_address])
    # この記述で同じ人の閲覧数はカウントされません！
    @reviews = Review.all
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

end
