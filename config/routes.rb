Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :courses, only: %i[index show]
  resources :bookmarks, only: %i[index create destroy]
  resources :reviews, only: %i[index create destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
