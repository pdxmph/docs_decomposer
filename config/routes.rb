Rails.application.routes.draw do
  
  devise_for :users

  
   root 'application#index'
   get 'docs' => 'application#docs'
   get 'my_flags' => 'application#my_flags'
   post 'pages/toggle_page_vote' => 'pages#toggle_page_vote'
   post 'pages/toggle_reviewed' => 'pages#toggle_reviewed'
   post 'comments/new' => 'comments#new'
   post 'pages/remove_tag' => 'pages#remove_tag'
   post 'pages/delete_comment' => 'pages#delete_comment'
   post 'pages/set_page_risk' => 'pages#set_page_risk'
   post 'pages/set_page_priority' => 'pages#set_page_priority'
   post 'pages/set_page_owner' => 'pages#set_page_owner'
   post 'pages/content_reimport' => 'pages#content_reimport'
   post 'pages/add_to_tag_list' => 'pages#add_to_tag_list'
   get '/tags/' => 'pages#tags'
   get '/tags/:tag_name' => 'pages#tag'
   get '/index' => 'application#indexed_words'
   get '/users/' => 'users#index'
   get '/missing_pages' => 'pages#missing_pages'
   match '/users/:id', :to => 'users#show', :as => :user,  :via => :get
   resources :repos
   
   resources :projects do
     resources :versions do
       resources :pages, shallow: true
     end
   end
   
   resources :comments

end
