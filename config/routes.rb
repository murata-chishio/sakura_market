Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  root 'home#index'
  namespace :admins do
    root 'home#index'
  end
  devise_for :admins, controllers: { sessions: 'admins/sessions' }
end
