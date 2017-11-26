Rails.application.routes.draw do
  devise_for :carriers, path: 'carriers', controllers: {
    sessions: 'carriers/sessions',
    registrations: 'carriers/registrations'
  }

  devise_for :shippers, path: 'shippers', controllers: {
    sessions: 'shippers/sessions',
    registrations: 'shippers/registrations'
  }

  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :shipments do
    resources :deals, only: [:create]
  end

  namespace :shipper do
    resources :shipments, only: [:index, :show, :update]
  end

  get 'carrier/shipments', to: 'deals#index'
  get 'carrier/shipments/pre-transit', to: 'deals#pre_transit'
  patch 'carrier/shipments/pre-transit', to: 'deals#to_in_transit'
  get 'carrier/shipments/in-transit', to: 'deals#in_transit'

  resources :facilities, only: [:index, :new, :create, :edit, :update, :destroy]

  # get "shipper/shipments", to: 'shippers#shipments'
  # get "carrier/shipments", to: 'carriers#shipments'
end
