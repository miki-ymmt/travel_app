# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#top'
  resources :users, only: %i[new create show edit update destroy]
  resources :trips do
    member do
      post 'add_todo'
      patch 'update_todo/:todo_id', to: 'trips#update_todo', as: :update_todo # 特定の trip に対してToDoを更新するアクション
      delete 'destroy_todo/:todo_id', to: 'trips#destroy_todo', as: :destroy_todo # 特定の trip に対してToDoを削除するアクション
    end
  end
  resources :passports, only: %i[new create show edit update destroy]
  get 'login' => 'user_sessions#new', as: :login
  post 'login' => 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy' # ログアウト機能
  get 'home' => 'home#index'
  get 'flights' => 'flights#index'
  post 'oauth/callback' => 'oauths#callback'
  get 'oauth/callback' => 'oauths#callback'
  get 'oauth/:provider' => 'oauths#oauth', as: :auth_at_provider
  get 'chatbots/ask' => 'chatbots#ask'
  post 'chatbots/answer' => 'chatbots#answer'
  post '/callback', to: 'line_bot#callback'
  get 'line_link' => 'line_auth#link'
  get 'line_auth/callback' => 'line_auth#callback'
  resources :password_resets, only: %i[new create edit update]
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # resources :tasks
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
