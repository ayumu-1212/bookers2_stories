Rails.application.routes.draw do
  get 'home/about' => "homes#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get :follows
      get :followers
    end
  end
  resources :books
  
  # relationship
  post "relationships/:follow_id" => "relationships#create", as: "relationship_create"
  delete "relationships/:follow_id" => "relationships#destroy", as: "relationship_destroy"
  
  root to: "homes#top"
end
