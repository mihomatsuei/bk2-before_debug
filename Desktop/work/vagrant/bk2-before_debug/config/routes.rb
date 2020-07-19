Rails.application.routes.draw do
  devise_for :users
  root to: 'home#top'
  # home/about' => 'homes#about'へ変更
  get 'home/about'
  resources :books
  resources :users,only: [:show,:index,:edit,:update]
end