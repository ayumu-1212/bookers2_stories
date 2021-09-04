Rails.application.routes.draw do
  get 'home/about' => "homes#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users do
    member do
      get :follows
      get :followers
    end
  end
  
  get "/chats/:id" => "chats#show", as: "chat"
  post "/chats/:opponent_id" => "chats#create", as: "chats"
  post "/chats/message/:chat_room_id" => "chats#create_message", as: "chat_message"
  
  # relationship
  post "relationships/:follow_id" => "relationships#create", as: "relationship_create"
  delete "relationships/:follow_id" => "relationships#destroy", as: "relationship_destroy"
  
  root to: "homes#top"
end
