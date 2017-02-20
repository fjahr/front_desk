Rails.application.routes.draw do
  devise_for :users
  use_doorkeeper

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :alexa do
        resources :handlers, only: [:create]
      end
    end
  end

  root to: "home#index"
end
