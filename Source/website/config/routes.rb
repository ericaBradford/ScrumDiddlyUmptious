Rails.application.routes.draw do

  get "log_out" => "sessions#destroy", :as =>"log_out"

  get "log_in" => "sessions#new", :as =>"log_in"

  get "sign_up" => "users#new", :as => "sign_up"

  get 'foods/show'

  get 'foods/new'

  get 'foods/create'

  get 'foods/edit'

  get 'foods/update'

  get 'foods/delete'

  get 'recipes/show'

  get 'recipes/new'

  get 'recipes/create'

  get 'recipes/edit'

  get 'recipes/update'

  get 'recipes/delete'

  get 'add_ingredient' => "recipes_ingredient#new", :as => 'add_ingredient'

  resources :recipes 
  resources :foods
  resources :users
  resources :sessions
  resources :recipes_ingredient

  root 'home#index'
end
