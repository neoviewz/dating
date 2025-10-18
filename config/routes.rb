Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  root to: 'home#index'
  get "up" => "rails/health#show", as: :rails_health_check

end
