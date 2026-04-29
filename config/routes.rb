Rails.application.routes.draw do
  resources :groups do
    post "join"
    delete "leave"
    get "new_event"
    post "send_event"
  end
  devise_for :admins, path: 'admin', controllers: {
    sessions: 'admin/admins/sessions',
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  namespace :admin do
    root 'users#index'
    resources :users, only: [:index, :destroy]
    resources :posts, only: [:index, :destroy]
  end

  root "homes#top"
  get "about", to: "homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'mypage', to: 'users#show'
  get 'chart', to: "chart#index"

  resources :users, only: [:show, :edit, :update]
  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end