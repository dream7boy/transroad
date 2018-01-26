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
    resources :shipments, only: [:index, :show, :update] do
      collection do
        get 'pre-transit', to: 'shipments#pre_transit_index'
        get 'in-transit', to: 'shipments#in_transit_index'
        get 'post-transit', to: 'shipments#post_transit_index'
      end

      member do
        get 'quotes', to: 'shipments#quotes'
        get 'quotes_req', to: 'shipments#quotes_req'
        get 'complete', to: 'shipments#complete'
      end
    end

    # resources :shipments, path: '/s', only: [:show] do
    #   get 'quotes', on: :member
    # end
  end

  get 'carrier/shipments', to: 'deals#index'
  get 'carrier/shipments/pre-transit', to: 'deals#pre_transit_index'
  patch 'carrier/shipments/next-transit', to: 'deals#to_next_transit'
  get 'carrier/shipments/in-transit', to: 'deals#in_transit_index'
  get 'carrier/shipments/post-transit', to: 'deals#post_transit_index'

  resources :facilities, only: [:index, :new, :create, :edit, :update, :destroy]

end
