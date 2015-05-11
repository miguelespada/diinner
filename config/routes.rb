Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  scope :auth, as: "auth" do
    get "auth0/callback" => "auth0#callback"
    get "failure" => "auth0#failure"
    get "logout" => "auth0#logout"
  end

  devise_for :restaurants
  devise_for :admins
<<<<<<< HEAD
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  namespace :restaurants do
    resources :tables
  end
=======
  
>>>>>>> da0ac5a2f4d443ec56f67b34f4fcb7e7b8430d46
  resources :restaurants

  get "admin" => "admin#index", as: "admin"

  scope :admin do
    get "/search" => "admin#search", as: "admin_search"
  end

  namespace :admin do
    resources :restaurants
    resources :tests
    resources :logs
    resources :users
  end

  scope :users do
    get "/login" => "users#login", as: "users_login"
  end

  namespace :users do
    # TODO why create a scope????
    # TODO redefine this routes
    scope :test do
      get "" => "test_responses#new", as: "test"
    end
    # TODO this is not a CRUD, better not to use all resources
    resources :test_responses
  end
  resources :users



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
