Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  # home/about' => 'homes#about'へ変更
  get 'home/about'
  resources :books do
   resource :favorites, only: [:create, :destroy]
   end
  resources :users,only: [:show,:index,:edit,:update]
  resources :post_comments, only: [:create, :destroy]
end