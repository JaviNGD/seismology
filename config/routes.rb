Rails.application.routes.draw do
  
  root "application#index"

  namespace :api do
    resources :features, only: [:index]
    resources :comments, only: [:create]
  end

end
