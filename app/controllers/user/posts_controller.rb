class User::PostsController < ApplicationController
  before_action :authenticate_user!
  #全てのアクションの前にuserのログインしているかどうかを確認するdeviseのメソッド
  impressionist :actions => [:show], :unique => [:session_hash]

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
    #@rank_posts = Post.find(Impression.group(:impressionable_id).order('count(impressionable_id) desc').limit(3).pluck(:impressionable_id))
  end

  # def ranking
  # @post_ranks = Post.all
  # end
  #↑実装しようとしていたランキング機能、いずれ実装

  def new
    @post = Post.new
    #↑新規投稿のフォームを作成する
    @tag = Tag.new
    @tag_lists = Tag.all
    #↑DBにあるタグを全て取得
  end

  def create
    @post = current_user.posts.new(post_params)
    #↓ここの記述はいまいち説明できない
    @tag_list = params[:post][:tag_name].split(',')
    #post,tag_nameのparamsから取ったデータを「,」で分けて@tag_listに入れる
    if @post.save
      @post.save_tag(@tag_list)
      #上の@tag_listで入れたデータをsave_tag(post.rbに記述)に入れる
      redirect_to posts_path
    else
      #render :new
      redirect_to new_post_path
      # 空欄で投稿画面に戻る
      flash[:cannot_save_of_posts] = "「店の名前」もしくは「店の説明」を入力してください。"
    end
  end

  def show
    @post = Post.find(params[:id])
    #↑クリックした投稿のidを取得
    @post_tags = @post.tags.distinct
    #↑@postに紐づいたtagを取得し、distinctで重複したものをまとめる
    @user = User.find(@post.user_id)
    #↑投稿のuser_idを取得し、@userに入れる
    @reviews = @post.reviews
    #↑投稿のidに紐づいたreviewだけを呼び出して並べたい
    #------------------------------------------------------
    #↓PV数を取得(実装予定機能)
    #@imagepost = Post.find_by(id: params[:id])
    #@post_pv = @post.impressions.size
    #------------------------------------------------------
    @tag_show = Tag.new
    #↑postのshowページで新しくタグを作るためにnewでフォームを作成
  end

  def edit
    @post = Post.find(params[:id])
    #↑クリックした投稿のidを取得
  end

  def update
    @post = Post.find(params[:id])
    #↑クリックした投稿のidを取得
    if @post.update(post_params)
    #↑(post_params)に入っていて、@postで取得したデータをupdateでする
        redirect_to post_path(@post.id)
    else
        flash[:cannot_update_of_posts] = "「店の名前」もしくは「店の説明」を入力してください。"
        render :edit
    end
  end

  private
  #↓viewで投稿したときにしたでpermit(許可)したデータをpost_paramsに入れる
  def post_params
    params.require(:post).permit(:user_id, :shop_name, :shop_explanation, :address, :latitude, :longitude, :is_released, :post_image)
  end

  #↓viewで投稿したときにしたでpermit(許可)したデータをtag_paramsに入れる
  def tag_params
    params.require(:tag).permit(:tag_name)
  end

end