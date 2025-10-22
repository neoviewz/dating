Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations'
  }
  
  root to: 'home#index'
  get "up" => "rails/health#show", as: :rails_health_check

  resources :profiles, only: [:show, :edit, :update]

  # Profile public URL by user's slug
  get '/u/:username', to: 'profiles#by_username', as: :user_profile

  # Validation endpoints
  get '/validate/username', to: 'validations#username'
  get '/validate/email', to: 'validations#email'

end
