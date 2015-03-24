Rails.application.routes.draw do

  
  devise_for :users
  
  # You can have the root of your site routed with "root"
   root 'welcome#index'
   get 'pages/version/:version' => 'pages#pages', :version => /[\w.]+/
   get 'pages/:id' => 'pages#page'
   get 'my_flags' => 'application#my_flags'
   post 'pages/downvote_page' => 'pages#downvote_page'
   post 'pages/upvote_page' => 'pages#upvote_page'
   post 'pages/toggle_page_vote' => 'pages#toggle_page_vote'
   post 'comments/new' => 'comments#new'
   post 'pages/remove_tag' => 'pages#remove_tag'
   post 'pages/set_page_risk' => 'pages#set_page_risk'
   post 'pages/set_page_priority' => 'pages#set_page_priority'
   post 'pages/add_to_tag_list' => 'pages#add_to_tag_list'
   get '/tags/:tag' => 'pages#tags'
   resources :pages 
   resources :comments

end
