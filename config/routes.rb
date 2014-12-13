Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/main'
  get 'home/who'
  get 'home/aboutus'
  get 'home/contact'
  get 'home/faq'
  get 'home/how'
  post '/home/contact_process.json' => "home#contact_process"
  get 'publishers/create' => "publishers#create2"
  get 'publishers/create2'
  post 'publishers/create_process'
  get 'publishers/manage'

  get 'publishers/edit/:id' => 'publishers#edit'

  post 'publishers/edit_process'
  get 'publishers/destroy_service/:id' => "publishers#destroy_service"
  get 'manages/edit_service/:id' => "manages#edit_service"
  post 'manages/edit_process'

  get 'products/search_detail/:id' => "products#search_detail"
  get 'products/search_result/:id' => "products#search_result"
  get 'products/cart'
  post 'products/add_cart'
  get 'advertisers/billing'
  post 'advertisers/add_credit'
  get 'advertisers/new_bidding'
  post 'advertisers/new_process'
  get "/products/attachment/:id" => "products#attachment"
  get "/products/comdocument/:id" => "products#comdocument"

  post "products/search"
  get '/products/search_company/:id' => "products#search_company"

  devise_for :users, :controllers => {:registrations => "registrations" ,:sessions => "sessions" , :passwords => "passwords", :omniauth_callbacks => "omniauth_callbacks"}
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  match '/users/signup_process' => 'users#signup_process', via: [:get]
  post '/users/confirm' => 'users#confirm'
  get '/users/company_parse/:id' => 'users#company_parse'

  #get '/publishers/preview/:id' => "publishers#preview"
  root 'home#main'
  get 'advertisers/project_results'
  get 'advertisers/project_results_detail'
  get 'home/account_profile'
  get 'users/company' => 'users#company'
  post 'users/company_update'
  get 'users/members'
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
  get 'home/search_detail'
  get 'home/whoru'
  get 'home/account_billing_invoice'
  get 'home/account_billing_receipt'
  get 'users/finish_signup'
  post 'users/signup_company'
  get 'confirmation/:id' => "users#email_confirmation"

  get 'users/finish_signup2'
  get 'users/email_confirm'
  get 'home/ready'
  get 'home/ready_billing'
  get 'home/ready_cashout'
  get 'home/ready_dashboard'
  get 'home/ready_project'
  get 'home/ready_search_detail'
  get 'home/fees'


  get '/manages/companies'
  get '/manages/company_profile/:id' => "manages#company_profile"
  post '/manages/company_update'
  get '/manages/services'
  get '/manages/create'
  post '/manages/create_process'
  get '/manages/destroy_service/:id' => "manages#destroy_service"
  get '/manages/analytics'

  resources "home" do
    get :autocomplete_company_name, :on => :collection
  end
  resources "publishers" do
    get :autocomplete_country_name, :on => :collection
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
