class User::PostsController < ApplicationController
  impressionist :actions => [:show], :unique => [:session_hash]

  def index
    @tag_list = Tag.all
    #↑ビューでタグ一覧を表示するために全取得。
    if params[:tag_name].present?
      tag = Tag.find_by(tag_name: params[:tag_name])
      if tag.present?
       @posts = tag.posts.page(params[:page])
      else
       @posts = Post.all.page(params[:page])
      end
    else
     @posts = Post.all.page(params[:page])
    end
    @post = current_user.posts.new
    #↑ビューのform_withのmodelに使う。
    @users = User.all
    #@all_ranks = Post.find(Post.group(:id).order('count(id) desc').limit(3).pluck(:id))
    @rank_posts = Post.order(impressions_count: 'DESC') # ソート機能を追加
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
    #ここの記述はいまいち説明できない
    @tag_list = params[:post][:tag_name].split(',')
    #post,tag_nameのparamsから取ったデータを「,」で分けて@tag_listに入れる
    if @post.save
      @post.save_tag(@tag_list)
      #上の@tag_listで入れたデータをsave_tag(post,rbに記述)に入れる
      #redirect_back(fallback_location: root_path)
      redirect_to post_path(@post.id)
    else
      redirect_to post_path(@post.id)
    end
  end

  def show
    #@users = User.all
    @post = Post.find(params[:id])
    #↑クリックした投稿を取得
    @post_tags = @post.tags
    #↑そのクリックした投稿に紐付けられているタグの取得。
    #ここは参考にしたところはpost_tagsだったが、テーブル名の都合上@post_tagsにした
    @user = User.find(@post.user_id)
    @reviews = Review.all
    #@imagepost = Post.find_by(id: params[:id])
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
