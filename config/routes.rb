Rails.application.routes.draw do
  
  root "application#index"

  namespace :api do
    resources :features, only: [:index]
  end

end
