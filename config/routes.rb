Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  root "homes#top"
  get "about", to: "homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'mypage', to: 'users#show'

  resources :users, only: [:show, :edit, :update]
  resources :posts
end