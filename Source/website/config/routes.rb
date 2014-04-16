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


  resources :recipes do
    member do
      get 'recipes_ingredient'
    end
  end

  resources :foods
  resources :users
  resources :sessions

  root 'home#index'
end
