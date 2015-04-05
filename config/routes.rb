Rails.application.routes.draw do

  version_pattern = /[\w.]+/
  
  devise_for :users

  
   root 'application#index'
   get 'docs' => 'application#docs'
   get 'my_flags' => 'application#my_flags'
   post 'pages/downvote_page' => 'pages#downvote_page'
   post 'pages/upvote_page' => 'pages#upvote_page'
   post 'pages/toggle_page_vote' => 'pages#toggle_page_vote'
   post 'comments/new' => 'comments#new'
   post 'pages/remove_tag' => 'pages#remove_tag'
   post 'pages/delete_comment' => 'pages#delete_comment'
   post 'pages/set_page_risk' => 'pages#set_page_risk'
   post 'pages/set_page_priority' => 'pages#set_page_priority'
   post 'pages/content_reimport' => 'pages#content_reimport'
   post 'pages/add_to_tag_list' => 'pages#add_to_tag_list'
   get '/tags/:tag' => 'pages#tags'
   get '/index' => 'application#indexed_words'
   match '/users/:id', :to => 'users#show', :as => :user,  :via => :get
   resources :projects do
     resources :versions do
       resources :pages, shallow: true
     end
   end
   
#   resources :pages,  except: [:show, :index, :get]
   resources :comments

end
