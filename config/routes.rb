Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", sessions: 'sessions', invitations: 'users/invitations' }
  root 'home#index'
  resources :organizations do
    resources :projects do
      resources :members, only: [:index, :destroy, :create]
    end
  end
  resources :artifacts
  post "checkout/create", to: "checkout#create", as: "checkout_create"
  post "billing_portal/create", to: "billing_portal#create", as: "billing_portal_create"
  resources :webhooks, only: [:create]
  get 'features', to: "home#features"
end
