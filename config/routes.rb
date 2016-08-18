Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#new'
  resources :expenses
  resources :expense_categories
  resources :income_categories
  resources :vendors
  resources :overviews, only: [:index]
  resources :budgets
  resources :incomes
end
