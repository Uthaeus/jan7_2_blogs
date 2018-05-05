Rails.application.routes.draw do

  resources :blogs
  devise_for :users
  root to: 'static#homepage'

  get 'static/calculator'
end
