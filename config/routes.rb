Rails.application.routes.draw do
  resources :users
  resource :session, only: [:new,  :destroy, :create]
end
