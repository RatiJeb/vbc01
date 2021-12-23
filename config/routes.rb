Rails.application.routes.draw do
  resources :posts
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  resources :tasks
  resources :projects
  resources :categories
  root to: 'projects#index'
  resources :users
  get 'countries/fetch_cities'
end
