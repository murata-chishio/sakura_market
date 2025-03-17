Rails.application.routes.draw do
  get 'up' => 'rails/health#show', as: :rails_health_check
  devise_for :admins
  namespace :admins do
    root to: 'home'
  end
end
