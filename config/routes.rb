Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  scope :auth, as: "auth" do
    get "auth0/callback" => "auth0#callback"
    get "failure" => "auth0#failure"
    get "logout" => "auth0#logout"
  end

  devise_for :restaurants
  devise_for :admins

  # TODO WTF this is wrong-> is not the same namespace and nested resources
  # TODO we need to change all the structure of menus and tables

  namespace :restaurants do
    resources :tables
  end

  resources :restaurants do
    resources :menus
  end

  get "admin" => "admin#index", as: "admin"

  scope :admin do
    get "/search" => "admin#search", as: "admin_search"

  end

  namespace :admin do
    resources :restaurants
    resources :tests
    resources :logs
    resources :users
    get "/tables" => "restaurants#tables", as: "tables"
  end

  scope :users do
    get "/login" => "users#login", as: "users_login"
  end

  resources :users do
    post "test/:test_id" => "test_responses#create", as: "test_response"
    get "test" => "test_responses#new", as: "test"
  end

  # You can have the root of your site routed with "root"
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
