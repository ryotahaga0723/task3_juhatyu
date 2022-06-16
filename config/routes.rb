Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'products#index'

  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:index, :new, :create, :show, :edit, :update]
  resources :companies
  resources :products

  resources :orders do
    collection do
      get :index_receive
      get :index_supply
      get :index_receive_month
    end
  end

  resources :categories

  resources :supplies do

    collection do
      get :ajax
    end
  end

  resources :statuses do
    member do
      post :update_1
      post :update_3
      post :update_6
    end
  end

  resources :deliveries

  resources :schedules do
    member do
      post :update_check
      post :update_noncheck
      post :update_check_task
      post :update_noncheck_task

    end
    collection do
      get :index_day
    end
  end

  resources :invoices

  resources :approvals do
    member do
      post :update_invoice
      post :update_order
    end
  end
  
end
