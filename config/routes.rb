Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'products#index'
  namespace :admins do
    root 'homes#index'
    resources :products do
      resource :position, only: :update, module: :products
    end
  end
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
end
