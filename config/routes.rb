RegistrationManager::Application.routes.draw do
  resources :content_partials

  resources :keywords

  resources :system_messages

  resources :payment_notifications

  # devise_for :users
  devise_for :users, controllers: { registrations: 'users/registrations', passwords: 'users/passwords' }
  resources :resources
  resources :addresses
  resources :person_addresses
  resources :people
  resources :emails
  resources :organizations
  resources :person_organizations
  resources :person_emails
  resources :events
  resources :coupons
 
  resources :reservations
  resource :reservation do
    post 'add_to_cart'
  # end 
  # resource :reservation do
    post 'mark_as_removed'
  end
  resources :reservation_carts
  resource :reservation_cart do
    post 'proceed_to_checkout'
  end
  
  resources :invoices
  resource :invoice do
    post 'apply_coupon_code'
    post 'cancel_invoice'
    post 'submit_transaction_to_firstdata'
  end
  # get 'reservation_carts/proceed_to_checkout'
   
  
  get "home/index"
  get "registration/index"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
