Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resource :order, only: [:new, :create]
  end
end
