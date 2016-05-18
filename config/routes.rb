Rails.application.routes.draw do

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  resources :users, only: [:show, :edit, :update]
  namespace :supervisor do
    root "users#index"
    resources :users
    resources :subjects, only: [:index]
    resources :courses
  end
end
