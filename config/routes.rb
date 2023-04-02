Rails.application.routes.draw do
  resources :user_records
  get 'download_csv', to: "user_records#download_csv"
  # devise_for :views
  # devise_for :admins
  devise_for :users
  resources :service_types
  resources :parcels
  resources :addresses
  resources :users
  root to: 'parcels#index'
  get '/search', to: 'search#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
