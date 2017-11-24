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
  get "carrier/shipments", to: 'deals#index'

  namespace :shipper do
    resources :shipments, only: [:index, :show, :edit, :update]
  end

  resources :facilities, only: [:index, :new, :create, :edit, :update, :destroy]

  # get "shipper/shipments", to: 'shippers#shipments'
  # get "carrier/shipments", to: 'carriers#shipments'
end
