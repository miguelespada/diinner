Rails.application.routes.draw do

  scope :auth, as: "auth" do
    get "auth0/callback" => "auth0#callback"
    get "failure" => "auth0#failure"
    get "logout" => "auth0#logout"
  end

  devise_for :restaurants
  devise_for :admins
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get "admin" => "admin#index", as: "admin"
  get "restaurants" => "restaurants#show", as: "restaurants"

  resources :restaurants

  scope :restaurants do
    get "/:id/profile" => "restaurants#profile", as: "restaurants_profile"
  end
  
  namespace :admin do
    resources :restaurants
    resources :users
  end

  get "user/login" => "users#login", as: "user_login"
  scope :users do
    get "/:id/profile" => "users#profile", as: "users_profile"
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
