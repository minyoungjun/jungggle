Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/main'
  get 'home/who'
  get 'home/aboutus'
  get 'home/contact'
  get 'home/faq'
  get 'home/how'
  get 'publishers/create'
  post 'publishers/create_process'
  get 'publishers/manage'
  get 'products/search_result/:id' => "products#search_result"
  get 'products/cart'
  post 'products/add_cart'
  get 'advertisers/billing'
  post 'advertisers/add_credit'
  get 'advertisers/new_bidding'
  post 'advertisers/new_process'


  devise_for :users, :controllers => {:registrations => "registrations" , :omniauth_callbacks => "omniauth_callbacks"}
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/users/signup_process' => 'users#signup_process', via: [:get]
  post '/users/confirm' => 'users#confirm'

  #get '/publishers/preview/:id' => "publishers#preview"
  root 'home#main'
  get 'advertisers/project_results'
  get 'advertisers/project_results_detail'
  get 'home/account_profile'
  get '/users/company' => 'home#account_company_profile'
  post '/users/company_update' => 'home#company_update'
  get '/users/company_members' => 'home#account_member'
  get 'home/account_member'
  get 'home/account_dashboard'
  #get 'home/account_billing' 
  #get 'home/account_ad_biddings'
  get 'home/account_projects'
  get 'home/account_manage_service'
  #get 'home/account_pub_biddings'  
  get 'advertisers/product_cards_view'
  get 'advertisers/product_table_view'
  get 'home/home_biddings'
  get 'home/search'
  get 'home/whoru'
  resources "home" do
    get :autocomplete_company_name, :on => :collection
  end
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
