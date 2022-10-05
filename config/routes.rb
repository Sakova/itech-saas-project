Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", sessions: 'sessions', invitations: 'users/invitations' }
  root 'home#index'
  resources :organizations do
    resources :projects
  end
  resources :artifacts
end
