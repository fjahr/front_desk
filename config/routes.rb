Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  use_doorkeeper

  resource :account
  resource :subscription
  resources :members
  resource :dashboard, only: [:show]

  mount StripeEvent::Engine, at: '/webhooks/stripe'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :alexa do
        resources :handlers, only: [:create]
      end
    end
  end

  root to: "home#index"
end
