Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'items#index'
  namespace :admins do
    root 'homes#index'
  end
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
end
