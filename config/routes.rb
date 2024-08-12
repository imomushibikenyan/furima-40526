Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :orders, only: [:index, :create]
  end
end
