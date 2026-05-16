Rails.application.routes.draw do
  get 'events/index'
  get 'events/show'

  resources :groups do
    post "join"
    delete "leave"
    get "new_event"
    post "send_event"

    resources :events, only: [:index, :show]
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

  get 'mypage', to: 'users#show'
  get 'chart', to: "chart#index"

  resources :users, only: [:show, :edit, :update]

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end
end
