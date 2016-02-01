Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  scope :ionic, as: "ionic" do
    get "user" => "ionic#user"
    post "user" => "ionic#update_user"
    get "cities" => "ionic#cities"
    get "notifications" => "ionic#notifications"
    get "read_notifications" => "ionic#read_notifications"
    get "table/search" => "ionic#search_tables", as: "search_tables"
    get "table/last_minute" => "ionic#last_minute", as: "last_minute"
    get "reservations" => "ionic#reservations"
    post "cancel_reservation" => "ionic#cancel_reservation"
    post "reserve" => "ionic#reserve"
    post "update_customer" => "ionic#update_customer"
    get "test" => "ionic#test"
    post "save_test" => "ionic#save_test"
  end

  scope :auth, as: "auth" do
    get "auth0/callback" => "auth0#callback"
    get "failure" => "auth0#failure"
    get "logout" => "auth0#logout"
  end

  devise_for :restaurants, :skip => [:passwords]
  as :restaurant do
    get 'restaurants/password/edit' => 'devise/registrations#edit', :as => 'edit_restaurant_registration'
    patch 'restaurants/password/:id' => 'devise/registrations#update', :as => 'restaurant_registration'
  end

  devise_for :admins, :skip => [:passwords]
  as :admin do
    get 'admins/password/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'
    patch 'admins/password/:id' => 'devise/registrations#update', :as => 'admin_registration'
  end

  scope :static do
    get "help" => "static#help"
  end

  namespace :restaurants, as: nil do
    resources :restaurants, only: [:index, :edit, :update, :show] do
      resources :payments, only: [:index]
      get "calendar" => "calendars#show"

      resources :notifications, only: [:index]
      resources :users, only: [:show]
      resources :menus

      resources :tables do
        delete "batch_delete", on: :collection
      end

      resources :reservations, only: [:show, :index] do
        get "validate"
        get "search_by_ticket", on: :collection
      end
    end
  end

  scope :admin do
    get "/" => "admin#index", as: "admin"
    get "/search" => "admin#search", as: "admin_search"
    get "/logs" => "admin#logs", as: "admin_logs"
    get "/map" => "admin#map", as: "admin_map"
    get "/settings" => "admin#settings", as: "settings"
    get "/process_reservations" => "admin#process_reservations", as: "process_reservations"
    get "/process_last_minute" => "admin#process_last_minute_diinners", as: "process_last_minute_diinners"
    get "/remove_old_tables" => "admin#remove_old_tables", as: "remove_old_tables"
    get "/invite_users_to_evaluate" => "admin#invite_users_to_evaluate", as: "invite_users_to_evaluate"
    get "/remove_old_logs" => "admin#remove_old_logs", as: "remove_old_logs"
    get "/test_email_notification" => "admin#test_email_notification", as: "test_email_notification"
  end

  namespace :admin do
    resources :restaurants
    resources :tests
    resources :cities
    resources :users, except: [:new, :create]
    resources :tables, only: [:show, :index] do
      get "process_payment",  on: :member
    end

    resources :menus, only: [:show, :index]
    resources :reservations, only: [:show, :index]
    resources :payments, only: [:index, :show]
    resources :evaluations, only: [:index]

    resources :home_items, only: [:update] do
      get "edit",  on: :collection
    end
  end

  get "/index" => "base_users#users", as: "users"

  namespace :users, as: nil do
    get "/login" => "users#login", as: "users_login"
    resources :users, except: [:index] do
      resources :restaurants, only: [:show]
      resources :menus, only: [:show]
      resources :notifications, only: [:index]

      delete "activity/delete/:activity_id" => "users#delete_activity", as: "delete_activity", on: :member
      post "test/:test_id" => "test_responses#create", as: "test_response"
      get "test" => "test_responses#new", as: "test"
      post "search" => "reservations#search", as: "search_tables"
      get "last_minute_diiners" => "reservations#new_last_minute", as: "last_minute_diinners"
      post "search_last_minute_diiners" => "reservations#search_last_minute", as: "search_last_minute_diinners"

      resources :reservations do
        resources :evaluations, only: [:new, :create]
        patch "cancel", as: "cancel"
      end
      patch "new_card" => "reservations#new_card"
      patch "reuse_card" => "reservations#reuse_card"
    end
  end

  root 'static#index'

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
