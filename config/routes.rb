Rails.application.routes.draw do
  get 'income_categories/index'

  get 'income_categories/new'

  get 'recurring_incomes/index'

  get 'recurring_incomes/new'

  get 'recurring_expenses/index'

  get 'recurring_expenses/new'

  devise_for :users
  root to: 'expenses#new'
  resources :expenses
  resources :categories
  resources :vendors
  resources :overviews, only: [:index]
  resources :budgets
  resources :incomes
end
