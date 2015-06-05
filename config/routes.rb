Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  get "ionic/users"

  scope :auth, as: "auth" do
    get "auth0/callback" => "auth0#callback"
    get "failure" => "auth0#failure"
    get "logout" => "auth0#logout"
  end

  devise_for :restaurants, :skip => [:passwords]
  # TODO WTF????
  as :restaurant do
    get 'restaurants/:id/password/edit' => 'restaurants#edit_password', :as => 'edit_restaurant_password'
    put 'restaurants/:id/password' => 'restaurants#update_password', :as => 'restaurant_password'
  end
  devise_for :admins

  scope :restaurant do
    get ":id/user/:user_id" => "restaurants#user", as: "restaurant_user"
    get ":id/notifications" => "restaurants#notifications", as: "restaurant_notifications"
  end

  resources :restaurants, except: [:new, :create] do
    get "calendar" => "tables#calendar", as: "calendar"
    resources :tables do
      # TODO WTF ??
      get "repeat", as: "repeat"
      post "repeat", as: "repeat_post"
    end
    resources :menus
    resources :reservations, only: [:show, :index], controller: "restaurants/reservations" do
      get "validate", as: "validate"
    end
  end

  scope :admin do
    get "/" => "admin#index", as: "admin"
    get "/search" => "admin#search", as: "admin_search"
    get "/logs" => "admin#logs", as: "admin_logs"
    get "/map" => "admin#map", as: "admin_map"
    get "/settings" => "admin#settings", as: "settings"
    get "/process_reservations" => "admin#process_reservations", as: "process_reservations"
  end

  namespace :admin do
    resources :restaurants
    resources :tests
    resources :cities
    resources :users, except: [:new, :create]
    resources :tables, only: [:show, :index]
    resources :menus, only: [:show, :index]
    resources :reservations, only: [:show, :index]
    resources :payments, only: [:index, :show]
  end

  scope :users do
    get "/login" => "users#login", as: "users_login"
    get ":id/notifications" => "users#notifications", as: "user_notifications"
    get "/index" => "base_users#users", as: "users"
  end

  resources :users, except: [:index] do
    post "test/:test_id" => "test_responses#create", as: "test_response"
    get "test" => "test_responses#new", as: "test"
    post "search" => "reservations#search", as: "search_tables"

    resources :reservations do
      get "restaurant" => "reservations#restaurant", as: "restaurant"
      get "menu" => "reservations#menu", as: "menu"
      patch "user_reuse_card" => "reservations#reuse_card", as: "reuse_card"
      patch "cancel", as: "cancel"
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
