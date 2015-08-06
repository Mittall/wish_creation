ProjectApp::Application.routes.draw do 

  resources :wishes

	resources :authorizations

  match '/auth/:provider/callback' => 'authorizations#create', via: [:get]

  resources :carts

  resources :contributors

  resources :event_products 

  resources :comments

  resources :events

  resources :posts 

  #faye_server '/faye', timeout: 25
  #get '/chat', to: RealtimeChatController

  resources :products

  resources :categories
  
  #get '/categories' => 'categories#new'
  #get 'add_event' => 'events#new', :as => :add_event
  #get '/events' => 'events#new'	, :as => :event_new 
  #get '/contributors' => 'contributors#new' 
  get '/friend' => 'friend/users#index', :as => :friend
  #get 'latest_products' => 'products#index', :as => :latest_products
 
  namespace :friend do
    resources :users 
  end  

  namespace :admin do
    resources :users, :settings, :footer_pages, :contacts, :languages, :email_templates
  end
  
  resources :event_products do
    resources :comments
  end

  resources :event_products do
    resources :contributors
  end

 resources :events do
    resources :event_products
  end
	
	 get '/userFunds/:id/:given_price' => 'contributors#userfund', :as => :fundfromfriend

   get 'events/filter/:status' => 'events#index', :as => :filter_event_status

   get '/products' => 'products#new'

   get '/contributors/my/:user_id' => 'contributors#index', :as => :contribution_by_me	

   get '/contributors/friend/:user_contribute_id' => 'contributors#index', :as => :contribution_by_friend

  

  resources :user_sessions
  get 'logout' => 'user_sessions#destroy', :as => :logout
  get 'login' => 'user_sessions#new', :as => :login
  match 'signup(/:registration_key)' => 'user_sessions#signup', :as => :signup, via: [:get, :post, :patch]

  match '/forgot_password' => 'fronts#forgot_password', :as => :forgot_password, via: [:get, :post]
  match '/change_password' => 'fronts#change_password', :as => :change_password, via: [:get, :post, :patch]
 # get 'dashboard' => 'fronts#dashboard', :as => :dashboard
   get 'dashboard' => 'events#index', :as => :dashboard
  match 'activate/:activation_key' => 'fronts#user_activation', :as => :activation_link, via: [:get]

  #match 'event_product/:event_product_id' => 'fronts#user_event_product', :as => :event_product_link, via: [:get, :post]

  match '/profile' => 'fronts#profile', :as => :profile, via: [:get, :post, :patch]
  get '/show_search_box/:toggle/:model/:pm' => 'fronts#show_search_box', :as => :show_search_box
  #get '/my_account' => 'fronts#my_account', :as => :my_account
	#match '/profile' => 'fronts#profile', :as => :my_account, via: [:get, :post, :patch]
  get '/about_us' => 'fronts#about_us', :as => :about_us
  get '/privacy_policy' => 'fronts#privacy_policy', :as => :privacy_policy
  get'/terms_and_condition' => 'fronts#terms_and_condition', :as => :terms_and_condition
  match '/contact_us' => 'fronts#contact_us', :as => :contact_us, via: [:get, :post, :patch]
  get '/other/:page_id' => 'fronts#other', :as => :other

  

  # You can have the root of your site routed with "root"
 # root 'fronts#dashboard'
	root 'events#index'

end
