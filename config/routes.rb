Rails.application.routes.draw do
  root 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, only: []

  namespace :api, defaults: { format: :json } do
    resources :users, only: [] do
      collection do
        post :sign_in, controller: :sessions, action: :create
        post :facebook_auth, controller: :sessions, action: :facebook_auth
      end
    end
  end  
end
