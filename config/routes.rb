Rails.application.routes.draw do
    #resources :files, only: [:new, :create]
    #root 'files#new'
  
  #resources :vacations
  root "api/v1/vacations#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise_for :users
  namespace :api do
    namespace :v1 do
      resources :vacations, only: [:new, :create, :index, :update, :destroy], except: [:show]
      #post :import
    end
  end
end
