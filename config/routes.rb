Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    root 'static_pages#home'
  end
  resources :users, only: [:index, :show], shallow: true do
    resources :friend_requests, only: [:index, :create, :destroy]
    resources :friends, only: [:index, :create, :destroy]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
