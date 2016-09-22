Rails.application.routes.draw do

  devise_for :users
  root to: 'expenses#index'
  resources :expenses
  resources :recurring_expenses
  resources :expense_categories
  resources :income_categories
  resources :vendors
  resources :overviews, only: [:index] do
    collection do
      get 'data'
    end
  end
  resources :budgets
  resources :incomes
  resources :recurring_incomes
  resources :pending_expenses do
    member do
      post 'clear'
    end
  end
end
