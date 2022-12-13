class User::PostsController < ApplicationController
  impressionist :actions => [:show], :unique => [:impressionable_id, :ip_address]
  def index
    @tag_list = Tag.all
    #↑ビューでタグ一覧を表示するために全取得。
    @posts = Post.all.page(params[:page])
    @post = current_user.posts.new
    #↑ビューのform_withのmodelに使う。
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
    @tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tag(@tag_list)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    #@tag_show = Tag.new(tag_params)
    #↑showで作った@tag_show = Tag.newにtag_paramsからデータを引っ張ってきて格納
    #@tag_show.save
    #↑@tag_showに入ったデータをセーブ（と思っていたらエラー(Routing Error)を吐き出し、全くうまくいきません。正直記述的に曖昧なまま進めているので自信がありません）
    #redirect_to root_path
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
    #impressionist :actions => [:show], :unique => [:impressionable_id, :ip_address]    # この記述で同じ人の閲覧数はカウントされません！
    @reviews = Review.all
    @imagepost = Post.find_by(id: params[:id])
    @post_pv = @post.impressions.size
    #↑PV数を取得
    @tag_show = Tag.new
    #↑postのshowページで新しくタグを作るためにnewでフォームを作成
  end

  def edit
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end
