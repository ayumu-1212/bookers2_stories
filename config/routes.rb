Rails.application.routes.draw do
  get 'home/about' => "homes#about"
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
  end
  root to: "homes#top"
end
