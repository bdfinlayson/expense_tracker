Rails.application.routes.draw do
  devise_for :users
  root to: 'application#index'
  resources :categories
  
  resources :forms, only: [:create]
  resources :expenses
  resources :recurring_expenses do
    collection do
      post 'archive'
    end
  end
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
  resources :recurring_incomes do
    collection do
      post 'archive'
    end
  end
  resources :pending_expenses do
    member do
      post 'clear'
    end
  end
  resources :account_payables
  resources :account_payable_histories, only: [:index]
end
