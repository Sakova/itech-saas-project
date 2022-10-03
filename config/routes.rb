Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations", invitations: 'users/invitations' }
  root 'home#index'
end
