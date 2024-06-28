Rails.application.routes.draw do
  resources :vacations
  root "api/v1/vacations#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # devise_for :users
  # namespace :api do
  #   namespace :v1 do
  #     resources :vacations
  #   end
  # end

  namespace :api do
    namespace :v1 do
      resources :vacations, only: [:index, :show, :create, :update, :destroy] do
        collection do 
          post :import_csv
        end
      end
    end
  end
end
