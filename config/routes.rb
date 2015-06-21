Rails.application.routes.draw do
  resources :nest, only: [:create]
end
