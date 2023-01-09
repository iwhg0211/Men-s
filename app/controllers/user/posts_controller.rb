class User::PostsController < ApplicationController
  before_action :authenticate_user!
  impressionist :actions => [:show], :unique => [:session_hash]
  #impressionist :actions => [:show], :unique => [:impressionable_id, :ip_address]

  def index
    @tag_list = Tag.all.page(params[:page]).per(10)
    #↑ビューでタグ一覧を表示するために全取得。
    if params[:tag_name].present?
      tag = Tag.find_by(tag_name: params[:tag_name])
      if tag.present?
       @posts = tag.posts.page(params[:page]).per(10)
      else
       @posts = Post.all.page(params[:page]).per(10)
      end
    else
     @posts = Post.all.page(params[:page]).per(10)
    end
    @post = current_user.posts.new
    #↑ビューのform_withのmodelに使う。
    @users = User.all
    #@all_ranks = Post.find(Post.group(:id).order('count(id) desc').limit(3).pluck(:id))
    #@rank_posts = Post.order(impressions_count: 'DESC') # ソート機能を追加
    @rank_posts = Post.find(Impression.group(:impressionable_id).order('count(impressionable_id) desc').limit(3).pluck(:impressionable_id))
  end

  def ranking
    @post_ranks = Post.all
  end

  def new
    @post = Post.new
    @tag_lists = Tag.all
  end

  def create
    @post = current_user.posts.new(post_params)
    #ここの記述はいまいち説明できない
    @tag_list = params[:post][:tag_name].split(',')
    #post,tag_nameのparamsから取ったデータを「,」で分けて@tag_listに入れる
    if @post.save
      @post.save_tag(@tag_list)
      #上の@tag_listで入れたデータをsave_tag(post,rbに記述)に入れる
      redirect_to posts_path
    else
      #render :new
      redirect_to new_post_path
      # 空欄で投稿画面に戻る
    end
  end

  def show
    #binding.pry
    @post = Post.find(params[:id])
    #↑クリックした投稿を取得
    @post_tags = @post.tags.distinct
    #@tag_post = TagPost.where(post_id: @post)
    #@post_tags = TagPost.where(post_id: @post)
    #↑そのクリックした投稿に紐付けられているタグの取得。
    #ここは参考にしたところはpost_tagsだったが、テーブル名の都合上@post_tagsにした
    @user = User.find(@post.user_id)
    @reviews = @post.reviews
    #↑投稿のidに紐づいたreviewだけを呼び出して並べたい
    #なので、whreでpostのidを取得させて並べさせる
    #tag = Tag.find(params[:id])
    #@posts = tag.posts
    #↑の記述はタグのidに紐づいた投稿の取得
    #@tag = Tag.find(params[:id])
    #↑の記述はタグ名を表示するため
    #@imagepost = Post.find_by(id: params[:id])
    #@post_pv = @post.impressions.size
    #↑PV数を取得
    @tag_show = Tag.new
    #↑postのshowページで新しくタグを作るためにnewでフォームを作成
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post.id)
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end