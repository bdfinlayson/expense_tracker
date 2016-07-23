Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#new'
  resources :expenses
  resources :categories
  resources :vendors
  resources :overviews, only: [:index]
  resources :budgets
  resources :incomes
end
