Rails.application.routes.draw do
  resources :tasks
  resources :projects
  resources :categories
  root to: 'projects#index'
  
end
