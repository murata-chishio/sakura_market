Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'products#index'
  namespace :admins do
    namespace :products do
      resource :display_order, only: :update, module: :products
    end
    root 'homes#index'
    resources :products
  end
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
end
