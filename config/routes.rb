Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users

  resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
  end

  get '/home/about' => 'homes#about', as: "about"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
