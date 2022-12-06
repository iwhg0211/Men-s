Rails.application.routes.draw do

  devise_for :admins,skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
    # ログインのURLを設定
  }
  devise_for :users,skip: [:passwords], controllers: {
    # userのパスワードは必要ないので、skipにしています。
    registrations: "user/registrations",
    # 新規登録のURLを設定
    sessions: "user/sessions"
    # ログインのURLを設定
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    # resourcesはindex,show,new,creste,edit,update,destroyを勝手に設定してくれます
    # only: にすると上記の７種類の中で好きなものだけ設定できます
    resources :posts, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :tag_posts, only: [:update]
    get 'posts/ranking' => 'posts#ranking'
  end

  scope module: :user do
    root to: "homes#top"
    get 'about' => 'homes#about', as: 'about'
    resources :users
    resources :posts
    resources :reviews
    get 'users/mypage' => 'users#mypage'
    get 'posts/ranking' => 'posts#ranking'
    get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 退会確認ページを表示するためのルーティング
    patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    # 論理削除するためのルーティング、patchにするのが大事
  end

end