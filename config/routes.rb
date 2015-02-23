Rails.application.routes.draw do

  
  devise_for :users
  
  # You can have the root of your site routed with "root"
   root 'welcome#index'
   get 'pages/version/:version' => 'pages#pages', :version => /[\w.]+/
   get 'pages/:id' => 'pages#page'
   post 'pages/downvote_page' => 'pages#downvote_page'
   post 'pages/upvote_page' => 'pages#upvote_page'
   post 'pages/toggle_page_vote' => 'pages#toggle_page_vote'
end
