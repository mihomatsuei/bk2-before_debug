Rails.application.routes.draw do
  devise_for :users

  root to: 'home#top'
  get 'home/about'
  # url名 → コントローラー名＃アクション名,as以降記載でidがつけられるようになる
  get 'user/following/:id' => 'users#following', as: 'following'
  get 'user/followed/:id' => 'users#followed', as: 'followed'
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  resources :books do
   resource :favorites, only: [:create, :destroy]
   end
  resources :users,only: [:show,:index,:edit,:update]
  resources :post_comments, only: [:create, :destroy]
end