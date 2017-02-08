Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }
  devise_scope :user do
    root 'static_pages#home'
  end

  resources :users, only: [:index, :show], shallow: true do
    get 'feed', on: :collection
    resources :friend_requests, only: [:index, :create, :destroy]
    resources :friends, only: [:index, :create, :destroy]
    resources :posts, only: [:show, :create, :destroy] do
      resources :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
  
end
