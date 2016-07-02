Rails.application.routes.draw do
  devise_for :users
  root to: 'expenses#new'
  resource :expenses, only: [:new, :update, :create]
end
