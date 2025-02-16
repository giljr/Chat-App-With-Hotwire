Rails.application.routes.draw do
  
  post 'add/user', to: 'rooms#add_user'

  resources :rooms do
    resources :messages
  end

  devise_for :users

  get "up" => "rails/health#show", as: :rails_health_check

  root "rooms#index"
end
