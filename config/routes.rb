Rails.application.routes.draw do

  devise_for :admins,skip: [:registrations,:passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "user/registrations",
    sessions: "user/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edit, :update]
    resources :reviews, only: [:index, :show, :edit, :update]
    resources :tags, only: [:index, :new, :create, :edit, :update]
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
  end

end