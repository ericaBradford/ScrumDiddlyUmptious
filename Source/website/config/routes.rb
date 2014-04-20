Rails.application.routes.draw do

  devise_for :users

  resources :recipes 
  resources :foods
  resources :recipes_ingredient
  root :to => 'home#index'
end
