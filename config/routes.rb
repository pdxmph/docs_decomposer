Rails.application.routes.draw do

  
  devise_for :users
  
  # You can have the root of your site routed with "root"
   root 'welcome#index'
   get 'pages/version/:version' => 'pages#pages', :version => /[\w.]+/
   get 'pages/:id' => 'pages#page'
   post 'flags/destroy_page_flags' => 'flags#destroy_page_flags'
   resources :flags
   
end
