Rails.application.routes.draw do
  get 'home/about' => "homes#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :books
  resources :groups do
    member do
      post "join"
      delete "leave"
    end
  end
  root to: "homes#top"
end
