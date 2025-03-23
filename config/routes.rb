Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'products#index'
  resources :products
  namespace :admins do
    resources :users, only: %i[index edit update destroy]
    root 'homes#index'
    resources :products do
      resource :position, only: :update, module: :products
    end
  end
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
  devise_for :users
end
