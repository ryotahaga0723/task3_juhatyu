Rails.application.routes.draw do
  resources :schedules
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :show, :edit, :update]
  resources :companies
  resources :products
  resources :orders
  resources :categories
  resources :supplies do
    collection do
    get :ajax
    end
  end
  resources :statuses do
    member do
      post :update_1
    end
  end
  resources :deliveries
  resources :schedules do
    member do
      post :update_check
      post :update_noncheck
    end
  end
end
