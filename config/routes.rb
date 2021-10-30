Rails.application.routes.draw do
  get 'accounts/create'
  get 'accounts/show'
  get 'home/index'
  devise_for :views
  devise_for :users
  #root to: 'pages#dashboard'
  root to: "home#index"
  post 'account' => 'accounts#create', as: :user_account

  get 'verify/reference' => 'transactions#verify_transactions', as: :verify_transactions
  get 'user/transactions' => 'transactions#user_transaction', as: :user_transactions

  get 'pages/dashboard'
  get 'pages/icons'
  get 'pages/profile'
  get 'pages/tables'
  get 'pages/login'
  get 'pages/register'
  get 'pages/upgrade'
end
