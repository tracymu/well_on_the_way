Rails.application.routes.draw do
  resources :wells, only: [:index, :show, :create]
end
