Rails.application.routes.draw do
  resources :tasks
  resources :projects
  resources :categories
  root to: 'projects#index'
  resources :users
  get 'countries/fetch_cities'
end
