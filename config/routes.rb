Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#new'
  resources :expenses
  resources :categories
  resources :vendors
end
