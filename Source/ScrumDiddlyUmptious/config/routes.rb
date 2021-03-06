Rails.application.routes.draw do

  post '/rate' => 'rater#create', :as => 'rate'

  get '/users/edit/:id', to: 'users#edit', :as => :edit_user
  put '/users/update/:id', to: 'users#update', :as => :update_user

  devise_for :users,
    :controllers => {:registrations => "my_devise/registrations"}


  delete 'users/delete/:id', to: 'my_devise/registrations#destroy', :as => 'cancel_account'

  get '/recipes/search', to: 'recipes#displayAdvancedSearchPage', :as => "advancedSearch"
  get '/recipes/search/results', to: 'recipes#prepareSearch', :as => "results"


  resources :recipes do
    resources :comments
  end

  get '/users/favorites', to: 'users#showFavs', :as => "favorites"

  resources :users do
    resources :preferences
  end

  put '/recipe/favorite/:recipe_id/:type', to: "recipes#favorite", :as => "make_favorite"

  root 'recipes#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
