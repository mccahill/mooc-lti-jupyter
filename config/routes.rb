Mooc_lti::Application.routes.draw do
  
  resources :lti_nonces do as_routes end
  resources :lti_user_sessions do as_routes end
  resources :lti_dockers do as_routes end
  resources :admins do as_routes end
  
  post 'lti', :to => 'lti#jupyter'
  match '/lti/jupyter', :to => 'lti#jupyter', :via => :get, :as =>"lti_jupyter"  

  
  get "ajax/users"

  resources :image, :except => :destroy do
    resources :group, :only => [:new,:create,:destroy]
  end
  
  match '/image', :to => 'image#index', :as => 'images'
  match '/image/ok/:id', :to => 'image#finish_up', :via => :get
  match '/image/complete', :to => 'image#complete', :via => :post
  match '/image/:id', :to => 'image#file_upload', :via => :post
 
  get "administration/index"
  post "administration/expire_emails"
 
  get "home/index"
  match 'home/logout'=>'home#logout'
  
  root :to => 'home#index'

 end
