Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  scope :auth, as: "auth" do
    get "auth0/callback" => "auth0#callback"
    get "failure" => "auth0#failure"
    get "logout" => "auth0#logout"
  end

  devise_for :restaurants
  devise_for :admins

  scope :restaurant do
    get ":id/reservations" => "restaurants#reservations", as: "restaurant_reservations"
    get ":id/user/:user_id" => "restaurants#user", as: "restaurant_user"
  end

  resources :restaurants do
    resources :tables
    resources :menus
  end


  scope :admin do
    get "/" => "admin#index", as: "admin"
    get "/search" => "admin#search", as: "admin_search"
    get "/map" => "admin#map", as: "admin_map"
  end

  namespace :admin do
    resources :restaurants
    resources :tests
    resources :cities
    resources :logs, only: [:index]
    resources :users, except: [:new, :create]
    resources :tables, only: [:show, :index]
    resources :menus, only: [:show, :index]
    resources :reservations, only: [:show, :index]
  end

  scope :users do
    get "/login" => "users#login", as: "users_login"
  end

  resources :users do
    post "test/:test_id" => "test_responses#create", as: "test_response"
    get "test" => "test_responses#new", as: "test"
    post "search" => "reservations#search", as: "search_tables"
    resources :reservations do
      get "restaurant" => "reservations#restaurant", as: "restaurant"
      get "menu" => "reservations#menu", as: "menu"
    end
  end

  root 'static_pages#index'

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
