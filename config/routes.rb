Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      namespace :alexa do
        resources :handlers, only: [:create]
      end
    end
  end
end
