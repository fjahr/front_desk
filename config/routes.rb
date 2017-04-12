Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  use_doorkeeper

  resource :subscription
  resources :members
  resource :dashboard, only: [:show]
  resources :charges, only: [:index, :show]
  resources :integrations, only: [:index]
  resources :visits, only: [:index, :destroy]

  mount StripeEvent::Engine, at: '/webhooks/stripe'
  get '/webhooks/slack/oauth_callback', to: 'slack#oauth_callback'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :alexa do
        resources :handlers, only: [:create]
      end
    end
  end

  resources "contacts", only: [:new, :create]
  get "/disclaimer", to: "pages#disclaimer"
  get "/privacy", to: "pages#privacy"
  get "/imprint", to: "pages#imprint"
  root to: "home#index"
end
