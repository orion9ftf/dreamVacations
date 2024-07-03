Rails.application.routes.draw do
  root "api/v1/vacations#index"
  # devise_for :users
  namespace :api do
    namespace :v1 do
      resources :vacations, only: [:new, :create, :index, :update, :destroy], except: [:show]
    end
  end
end
