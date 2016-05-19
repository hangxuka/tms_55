Rails.application.routes.draw do

  root "static_pages#home"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  resources :users, except: [:destroy, :new, :create]
  resources :user_subjects, only: [:show]
  resources :user_courses, only: [:show]

  namespace :supervisor do
    root "users#index"
    resources :users
    resources :subjects, only: [:show, :index]
    resources :courses do
      resource :assign_trainees, only: [:edit, :update]
      resource :assign_trainers, only: [:edit, :update]
    end
  end
end
